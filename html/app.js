"use strict";
// /manageconsumables panel. Same look and helpers as bfrp_crafting's admin panel
const RESOURCE = typeof GetParentResourceName === "function" ? GetParentResourceName() : "ez_consumables";
const $ = (id) => document.getElementById(id);

const S = {
    open: false,
    settings: {},
    A: {}, // panel text (Lang.admin)
    data: null,
    pendingRender: false,
};

const AD = {
    tab: "consumables",
    sel: { consumables: null, effects: null }, // id or "new"
    filters: { consumables: { search: "", kind: "all" }, effects: { search: "" } },
    page: { consumables: 1, effects: 1 },
    draft: null,
    dirty: false,
    confirm: false,
    leaveKey: null,
};

// ---------------------------------------------------------------- Helpers

function post(name, data = {}) {
    return fetch(`https://${RESOURCE}/${name}`, {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=UTF-8" },
        body: JSON.stringify(data),
    });
}

function adminPost(action, payload) {
    post("admin", { action, payload }).catch(() => {});
}

const sounds = {};
function sound(name, volume = 0.25) {
    try {
        const audio = sounds[name] || (sounds[name] = new Audio(`assets/sounds/${name}.mp3`));
        audio.volume = volume;
        audio.currentTime = 0;
        audio.play().catch(() => {});
    } catch (e) {}
}

function esc(text) {
    return String(text ?? "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;").replace(/'/g, "&#39;");
}

function fmt(text, ...args) {
    let i = 0;
    return String(text ?? "").replace(/%s/g, () => args[i++] ?? "");
}

// Lua sends empty tables as {} and lists as arrays: always get an array
const arr = (v) => (Array.isArray(v) ? v : v && typeof v === "object" ? Object.values(v) : []);
const clone = (v) => JSON.parse(JSON.stringify(v));

function img(name, label, size = "") {
    const letter = esc(String(label || name || "?").trim().charAt(0).toUpperCase() || "?");
    if (!name) return `<div class="thumb ${size}"><span class="noimg">?</span></div>`;
    const src = (S.settings.image || "nui://vorp_inventory/html/img/items/%s.png").replace("%s", name);
    return `<div class="thumb ${size}"><img src="${esc(src)}" data-l="${letter}" loading="lazy" decoding="async" onerror="imgFail(this)"></div>`;
}
window.imgFail = (el) => {
    const span = document.createElement("span");
    span.className = "noimg";
    span.textContent = el.dataset.l || "?";
    el.replaceWith(span);
};

// Re-renders keep each [data-scroll] element's scroll position
function keepScroll(fn) {
    const scrolls = {};
    document.querySelectorAll("[data-scroll]").forEach((el) => (scrolls[el.dataset.scroll] = el.scrollTop));
    fn();
    document.querySelectorAll("[data-scroll]").forEach((el) => {
        if (scrolls[el.dataset.scroll] !== undefined) el.scrollTop = scrolls[el.dataset.scroll];
    });
}

function typing() {
    const active = document.activeElement;
    return active && /^(INPUT|SELECT|TEXTAREA)$/.test(active.tagName);
}

function toast(text, ok) {
    const el = document.createElement("div");
    el.className = "toast" + (ok === true ? " toast--ok" : ok === false ? " toast--bad" : "");
    el.textContent = text;
    $("toasts").appendChild(el);
    while ($("toasts").children.length > 4) $("toasts").firstChild.remove();
    setTimeout(() => el.classList.add("out"), 3600);
    setTimeout(() => el.remove(), 4100);
}

// Server updates wait while the admin is typing in the panel
function renderSoon() {
    if (typing() && $("body").contains(document.activeElement)) {
        S.pendingRender = true;
        return;
    }
    render();
}
document.addEventListener("focusout", () => {
    setTimeout(() => {
        if (!S.pendingRender || typing()) return;
        S.pendingRender = false;
        render();
    }, 0);
});

function closeApp(tell = true) {
    if (S.open) sound("menu_close", 0.3);
    S.open = false;
    $("app").classList.add("hidden");
    if (tell) post("close").catch(() => {});
}

// ---------------------------------------------------------------- Data

function normalizeRow(kind, row) {
    if (kind === "consumables") {
        row.gives = arr(row.gives);
        row.requires = arr(row.requires);
        row.prop = row.prop && typeof row.prop === "object" && !Array.isArray(row.prop) ? row.prop : null;
    } else {
        row.postfx = arr(row.postfx);
    }
    return row;
}

/**
 * The server only sends what changed since the panel was last open (d.rows and/or d.static); the rest is kept from
 * before. Returns false if something is missing here, and asks for everything again
 */
function setAdminData(d) {
    const D = S.data || {};
    if ((!d.rows && !D.consumables) || (!d.static && !D.items)) {
        post("adminResync").catch(() => {});
        return false;
    }
    if (d.static) {
        const st = d.static;
        D.items = arr(st.items);
        D.itemMap = new Map(D.items.map((i) => [i.name, i]));
        D.animations = arr(st.animations);
        D.animMap = new Map(D.animations.map((a) => [a.key, a]));
        D.kinds = arr(st.kinds);
        D.kindMap = new Map(D.kinds.map((k) => [k.key, k.label]));
        D.lists = { bones: arr(st.bones), screenEffects: arr(st.screenEffects), timecycles: arr(st.timecycles), shakes: arr(st.shakes) };
        D.limits = st.limits || { consumables: {}, effects: {} };
    }
    if (d.rows) {
        for (const kind of ["consumables", "effects"]) {
            D[kind] = new Map();
            for (const row of arr(d.rows[kind])) D[kind].set(row.id, normalizeRow(kind, row));
        }
    }
    D.defaults = d.defaults || D.defaults || {};
    S.data = D;
    return true;
}

/** An item from the items table, or null if it isn't there (a stand-in if the list didn't load) */
function itemInfo(name) {
    const D = S.data;
    if (!name) return null;
    if (!D.items.length) return { name, label: name, usable: true };
    return D.itemMap.get(name) || null;
}

const itemLabel = (name) => (itemInfo(name) || {}).label || name || "";

function usedBy(effectId) {
    let n = 0;
    for (const c of S.data.consumables.values()) if (c.effect === effectId) n++;
    return n;
}

function animationOf(key) {
    const D = S.data;
    return D.animMap.get(key || D.defaults.animation) || D.animMap.get(D.defaults.animation) || {};
}

function blankRow(kind) {
    const D = S.data;
    if (kind === "effects") {
        return { id: null, label: "", duration: null, postfx: [], start_fx: "", end_fx: "", timecycle: "", strength: 1, drunk: 0, shake: "", shake_amount: 0, shake_time: 0, blur: false, enabled: true };
    }
    const kindFilter = AD.filters.consumables.kind;
    return {
        id: null, item: "", kind: kindFilter !== "all" ? kindFilter : D.defaults.kind, hunger: 0, thirst: 0, stress: 0, metabolism: 0,
        stamina: 0, inner_health: 0, outer_health: 0, inner_health_gold: 0, outer_health_gold: 0, inner_stamina_gold: 0, outer_stamina_gold: 0,
        alcohol: 0, cooldown: 0, animation: null, interaction: "", prop: null, effect: null, effect_time: null, clear_effects: false, sober: false,
        gives: [], requires: [], uses: 1, use_time: null, enabled: true,
    };
}

// ---------------------------------------------------------------- Pages

const pageSize = () => Math.max(1, Number(S.settings.pageSize) || 25);

/** One page of a list: {items, page, pages, from, to, total, offset} */
function paged(list, page, size) {
    const pages = Math.max(1, Math.ceil(list.length / size));
    page = Math.min(Math.max(1, Math.floor(page) || 1), pages);
    const offset = (page - 1) * size;
    return { items: list.slice(offset, offset + size), page, pages, offset, from: list.length ? offset + 1 : 0, to: Math.min(offset + size, list.length), total: list.length };
}

/** Page buttons: ‹ 1 … 4 5 6 … 20 › and "21-40 of 426" */
function pagerHtml(p) {
    if (p.pages <= 1) return "";
    const nums = new Set([1, p.pages, p.page - 1, p.page, p.page + 1]);
    if (p.page <= 3) [2, 3, 4].forEach((n) => nums.add(n));
    if (p.page >= p.pages - 2) [p.pages - 1, p.pages - 2, p.pages - 3].forEach((n) => nums.add(n));
    const list = [...nums].filter((n) => n >= 1 && n <= p.pages).sort((a, b) => a - b);
    let html = `<button class="page page--arrow framed" data-act="page" data-page="${p.page - 1}" ${p.page <= 1 ? "disabled" : ""}><img src="assets/images/selection_arrow_left.png" alt=""></button>`;
    let last = 0;
    for (const n of list) {
        if (n - last > 1) html += `<span class="page page--gap">&hellip;</span>`;
        html += `<button class="page framed ${n === p.page ? "active" : ""}" data-act="page" data-page="${n}">${n}</button>`;
        last = n;
    }
    html += `<button class="page page--arrow framed" data-act="page" data-page="${p.page + 1}" ${p.page >= p.pages ? "disabled" : ""}><img src="assets/images/selection_arrow_right.png" alt=""></button>`;
    return `<div class="pager">${html}<span class="pager__info">${esc(fmt(S.A.pageInfo, p.from, p.to, p.total))}</span></div>`;
}

// ---------------------------------------------------------------- Lists (left column)

const byLabel = (a, b) => a.localeCompare(b, undefined, { sensitivity: "base" });

/** Every row of a tab that matches its search and filter, in display order */
function adminList(kind) {
    const D = S.data;
    if (kind === "effects") {
        const q = AD.filters.effects.search.trim().toLowerCase();
        const all = [...D.effects.values()].sort((a, b) => byLabel(a.label, b.label) || a.id - b.id);
        return q ? all.filter((e) => e.label.toLowerCase().includes(q) || e.postfx.some((p) => p.toLowerCase().includes(q))) : all;
    }
    const f = AD.filters.consumables;
    const q = f.search.trim().toLowerCase();
    let list = [...D.consumables.values()];
    if (f.kind !== "all") list = list.filter((c) => c.kind === f.kind);
    if (q) {
        list = list.filter((c) => {
            const effect = c.effect && D.effects.get(c.effect);
            return (
                String(c.id) === q ||
                c.item.toLowerCase().includes(q) ||
                itemLabel(c.item).toLowerCase().includes(q) ||
                (effect && effect.label.toLowerCase().includes(q)) ||
                c.gives.some((g) => g.name.toLowerCase().includes(q))
            );
        });
    }
    return list.sort((a, b) => byLabel(itemLabel(a.item), itemLabel(b.item)) || a.id - b.id);
}

/** Turns to the page that has this row */
function revealRow(kind, id) {
    const index = adminList(kind).findIndex((r) => r.id === id);
    if (index >= 0) AD.page[kind] = Math.floor(index / pageSize()) + 1;
}

/** "Hunger 35 · Thirst 5 · Alcohol 90 · High" */
function statsText(c) {
    const A = S.A;
    const D = S.data;
    const parts = [];
    for (const key of ["hunger", "thirst", "stress", "alcohol", "inner_health", "outer_health", "stamina"]) {
        if (c[key]) parts.push(`${A[key === "inner_health" ? "innerHealth" : key === "outer_health" ? "outerHealth" : key]} ${c[key] > 0 ? "+" : ""}${c[key]}`);
    }
    const effect = c.effect && D.effects.get(c.effect);
    if (effect) parts.push(effect.label);
    if (c.uses > 1) parts.push(fmt(A.puffs, c.uses));
    if (c.gives.length) parts.push(`${A.gives}: ${c.gives.map((g) => `${g.count}x ${itemLabel(g.name)}`).join(", ")}`);
    return parts.slice(0, 5).join(" · ");
}

function adminListHtml() {
    const A = S.A;
    const D = S.data;
    const sel = AD.sel[AD.tab];
    const p = paged(adminList(AD.tab), AD.page[AD.tab], pageSize());
    AD.page[AD.tab] = p.page;
    let rows;
    if (AD.tab === "consumables") {
        rows = p.items.map((c) => {
            const info = itemInfo(c.item);
            return `<div class="list-row ${sel === c.id ? "active" : ""} ${c.enabled ? "" : "off"}" data-act="pick" data-id="${c.id}">
                ${img(c.item, itemLabel(c.item), "thumb--s")}
                <span class="list-row__name"><b>${esc(itemLabel(c.item))}</b><small>${esc(D.kindMap.get(c.kind) || c.kind)} · <span class="list-row__stats">${esc(statsText(c) || c.item)}</span></small></span>
                ${info ? "" : `<span class="chip chip--bad">${esc(A.unknownItem)}</span>`}
                ${c.enabled ? "" : `<span class="chip">${esc(A.off)}</span>`}
            </div>`;
        });
    } else {
        rows = p.items.map((e) => {
            const time = e.duration || D.defaults.effectTime;
            return `<div class="list-row ${sel === e.id ? "active" : ""} ${e.enabled ? "" : "off"}" data-act="pick" data-id="${e.id}">
                <span class="list-id">#${e.id}</span>
                <span class="list-row__name"><b>${esc(e.label)}</b><small>${esc(time)}s · ${esc(fmt(A.usedBy, usedBy(e.id)))}</small></span>
                ${e.enabled ? "" : `<span class="chip">${esc(A.off)}</span>`}
            </div>`;
        });
    }
    return { rows: rows.length ? rows.join("") : `<div class="empty">${esc(A.noMatches)}</div>`, pager: pagerHtml(p) };
}

function listHeadHtml() {
    const A = S.A;
    const f = AD.filters[AD.tab];
    let extra = "";
    if (AD.tab === "consumables") {
        const counts = {};
        for (const c of S.data.consumables.values()) counts[c.kind] = (counts[c.kind] || 0) + 1;
        extra = `<select id="aKind" class="input"><option value="all">${esc(A.allKinds)}</option>${S.data.kinds
            .map((k) => `<option value="${esc(k.key)}" ${f.kind === k.key ? "selected" : ""}>${esc(k.label)} (${counts[k.key] || 0})</option>`)
            .join("")}</select>`;
    }
    return `<div class="row">
        <div class="search"><input id="aSearch" class="input" placeholder="${esc(A.search)}" value="${esc(f.search)}" autocomplete="off"></div>
        <button class="btn btn--small framed" data-act="new">+ ${esc(A.new)}</button>
    </div>${extra}`;
}

// ---------------------------------------------------------------- Editor (right column)

const bind = (path, type = "text") => `data-bind="${path}" data-type="${type}"`;

function toggleHtml(path, on) {
    return `<button class="toggle ${on ? "on" : ""}" data-act="toggle" data-path="${path}"></button>`;
}

function numberField(label, path, value, attrs = "", cls = "") {
    return `<label class="field ${cls}">${esc(label)}<input class="input" type="number" ${attrs} ${bind(path, "float")} value="${value ?? ""}"></label>`;
}

/**
 * A slider for a number with known limits (Limits in shared/functions.lua), with the exact value in a box beside it.
 * The fill grows from 0, so draining (left of 0) and filling (right of 0) read at a glance
 * opts: kind ("consumables" | "effects"), ends (key in A.ends, default the path), hint, marks [{value, label}]
 */
function sliderHtml(label, path, value, opts = {}) {
    const [min, max, step] = S.data.limits[opts.kind || "consumables"][path] || [0, 100, 1];
    const ends = (S.A.ends || {})[opts.ends || path] || ["", ""];
    const v = value ?? 0;
    const pct = (n) => ((Math.min(Math.max(n, min), max) - min) / (max - min)) * 100;
    const marks = (opts.marks || [])
        .filter((m) => m.value > min && m.value < max)
        .map((m) => `<span class="slider__mark" style="left:${pct(m.value)}%"><i></i>${esc(m.label)}</span>`)
        .join("");
    const range = `min="${min}" max="${max}" step="${step}"`;
    return `<div class="field slider span2" data-slider-box="${path}" data-min="${min}" data-max="${max}">
        <div class="slider__head"><span>${esc(label)}</span><input class="input slider__num" type="number" ${range} ${bind(path, "float")} data-slider="${path}" value="${v}"></div>
        <div class="slider__track ${marks ? "slider__track--marks" : ""}">
            <input class="slider__range" type="range" ${range} ${bind(path, "float")} data-slider="${path}" value="${v}">
            ${min < 0 ? `<span class="slider__zero" style="left:${pct(0)}%"></span>` : ""}${marks}
        </div>
        <div class="slider__ends"><span>${esc(ends[0])}</span><span>${esc(ends[1])}</span></div>
        ${opts.hint ? `<div class="hint">${esc(opts.hint)}</div>` : ""}
    </div>`;
}

/** Colours a slider's track from 0 to its value, red when it drains */
function paintSlider(box) {
    const range = box.querySelector(".slider__range");
    const min = Number(box.dataset.min);
    const max = Number(box.dataset.max);
    const pct = (n) => ((Math.min(Math.max(n, min), max) - min) / (max - min)) * 100;
    const value = Number(range.value);
    const zero = pct(Math.min(Math.max(0, min), max));
    range.style.setProperty("--from", `${Math.min(zero, pct(value))}%`);
    range.style.setProperty("--to", `${Math.max(zero, pct(value))}%`);
    range.classList.toggle("slider__range--neg", value < 0);
}

function paintSliders() {
    document.querySelectorAll("[data-slider-box]").forEach(paintSlider);
}

/** Moving the slider updates the box, typing in the box moves the slider */
function syncSlider(input) {
    const box = input.closest("[data-slider-box]");
    const value = getPath(AD.draft, input.dataset.slider) ?? 0;
    box.querySelectorAll("[data-slider]").forEach((el) => {
        if (el !== input) el.value = value;
    });
    paintSlider(box);
}

/** A typed number past the ends is pulled back in when the box is left */
function clampSlider(input) {
    const box = input.closest("[data-slider-box]");
    const min = Number(box.dataset.min);
    const max = Number(box.dataset.max);
    const value = Number(input.value);
    input.value = Number.isFinite(value) && input.value !== "" ? Math.min(Math.max(value, min), max) : 0;
    applyBind(input);
    syncSlider(input);
}

/** A text input with a dropdown of suggestions. source = "items" (item picker) or a list in S.data.lists */
function pickerHtml(path, value, source, placeholder, showLabel = source === "items") {
    let bad = false;
    let note = "";
    if (source === "items" && value) {
        const info = itemInfo(value);
        bad = !info;
        note = info ? (info.usable === false && path === "item" ? `<span class="gold">${esc(S.A.notUsable)}</span>` : esc(info.label)) : esc(S.A.unknownItem);
    }
    return `<div class="picker">
        <input class="input ${bad ? "input--bad" : ""}" ${bind(path)} data-picker="${source}" value="${esc(value || "")}" placeholder="${esc(placeholder || "")}" autocomplete="off">
        <div class="picker__list hidden"></div>
        ${showLabel ? `<div class="label-preview ${bad ? "bad" : ""}">${note}</div>` : ""}
    </div>`;
}

/** A list of names typed as chips, with suggestions from S.data.lists[source] */
function chipsHtml(path, values, placeholder, source) {
    const tags = values.map((v, i) => `<span class="tag">${esc(v)}<button data-act="chipRemove" data-path="${path}" data-i="${i}">&#x2715;</button></span>`).join("");
    return `<div class="chips">${tags}<input class="input" data-chip="${path}" data-source="${source}" placeholder="${esc(placeholder)}" autocomplete="off"><div class="picker__list hidden"></div></div>`;
}

function vectorHtml(label, path, value, fallback, step) {
    const v = value || {};
    const f = fallback || {};
    const cell = (axis) => `<input class="input" type="number" step="${step}" ${bind(`${path}.${axis}`, "float")} value="${v[axis] ?? ""}" placeholder="${f[axis] ?? 0}">`;
    return `<div class="vec"><span>${esc(label)}</span>${cell("x")}${cell("y")}${cell("z")}</div>`;
}

function actionsHtml(d, canDuplicate) {
    const A = S.A;
    return `<div class="editor__actions">
        <button class="btn btn--primary framed" data-act="save">${esc(d.id ? A.save : A.create)}</button>
        ${d.id && canDuplicate ? `<button class="btn framed" data-act="duplicate">${esc(A.duplicate)}</button>` : ""}
        ${d.id ? `<button class="btn framed" data-act="revert">${esc(A.revert)}</button>` : ""}
        <span class="grow"></span>
        ${d.id ? `<button class="btn ${AD.confirm ? "btn--confirm" : "btn--danger"} framed" data-act="delete">${esc(AD.confirm ? A.confirmDelete : A.delete)}</button>` : ""}
    </div>`;
}

function group(title, hint, body, extra = "") {
    return `<div class="group">
        <div class="group__head"><h3>${esc(title)}</h3>${extra}</div>
        ${hint ? `<div class="hint">${esc(hint)}</div>` : ""}
        ${body}
    </div>`;
}

function propHtml(d, anim) {
    const A = S.A;
    if (anim.interaction || anim.none) return `<div class="hint">${esc(A.noProp)}</div>`;
    const base = anim.prop || {};
    const prop = d.prop || {};
    const scripted = anim.modelOnly; // the animation places the prop itself (coffee, stew, cigarette, chew): only the model can change
    return `<div class="form-grid">
        <div class="field span2">${esc(A.propModel)}${pickerHtml("prop.model", prop.model, "none", base.model || "", false)}</div>
        ${scripted ? "" : `<div class="field span2">${esc(A.propBone)}${pickerHtml("prop.bone", prop.bone, "bones", base.bone || "SKEL_R_HAND", false)}</div>`}
    </div>
    ${scripted ? "" : vectorHtml(A.offset, "prop.offset", prop.offset, base.offset, 0.01) + vectorHtml(A.rotation, "prop.rotation", prop.rotation, base.rotation, 1)}`;
}

function consumableHeadHtml(d) {
    const label = d.item ? itemLabel(d.item) : S.A.newConsumable;
    return `${img(d.item, label, "thumb--m")}<div class="grow"><h2>${esc(label)}</h2><small>${esc(d.item || "")}${d.id ? ` · #${d.id}` : ""}</small></div>`;
}

/** The picture and name at the top follow the item picker */
function updateHead() {
    const el = $("editorHead");
    if (el && AD.draft) el.innerHTML = consumableHeadHtml(AD.draft);
}

function consumableEditorHtml(d) {
    const A = S.A;
    const D = S.data;
    const anim = animationOf(d.animation);
    const effects = [...D.effects.values()].sort((a, b) => byLabel(a.label, b.label));
    const effect = d.effect && D.effects.get(d.effect);

    const status = group(
        A.status,
        A.statusHint,
        `<div class="form-grid">
            ${sliderHtml(A.hunger, "hunger", d.hunger)}
            ${sliderHtml(A.thirst, "thirst", d.thirst)}
            ${sliderHtml(A.stress, "stress", d.stress)}
            ${sliderHtml(A.metabolism, "metabolism", d.metabolism, { hint: A.metabolismHint })}
            ${sliderHtml(A.alcohol, "alcohol", d.alcohol, {
                hint: fmt(A.alcoholHint, D.defaults.drunk, D.defaults.passOut),
                marks: [{ value: D.defaults.drunk, label: A.drunkMark }, { value: D.defaults.passOut, label: A.passOutMark }],
            })}
        </div>`
    );

    const cores = group(
        A.cores,
        A.coresHint,
        `<div class="form-grid">
            ${sliderHtml(A.innerHealth, "inner_health", d.inner_health)}
            ${sliderHtml(A.outerHealth, "outer_health", d.outer_health)}
            ${sliderHtml(A.stamina, "stamina", d.stamina)}
            <span class="span2"></span>
            ${sliderHtml(A.innerHealthGold, "inner_health_gold", d.inner_health_gold, { ends: "gold" })}
            ${sliderHtml(A.outerHealthGold, "outer_health_gold", d.outer_health_gold, { ends: "gold" })}
            ${sliderHtml(A.innerStaminaGold, "inner_stamina_gold", d.inner_stamina_gold, { ends: "gold" })}
            ${sliderHtml(A.outerStaminaGold, "outer_stamina_gold", d.outer_stamina_gold, { ends: "gold" })}
        </div>`
    );

    const animation = group(
        A.animation,
        "",
        `<div class="form-grid">
            <label class="field span2">${esc(A.animation)}<select class="input" ${bind("animation")} data-rerender="1">${D.animations
                .map((a) => `<option value="${esc(a.key)}" ${anim.key === a.key ? "selected" : ""}>${esc(a.label)}</option>`)
                .join("")}</select></label>
            ${
                anim.interaction
                    ? `<div class="field span2">${esc(A.interaction)} <span class="hint">${esc(A.interactionHint)}</span>${pickerHtml("interaction", d.interaction, "none", anim.interaction, false)}</div>`
                    : ""
            }
            ${
                anim.smoke
                    ? `<label class="field">${esc(A.uses)}<input class="input" type="number" min="1" max="50" ${bind("uses", "int")} value="${d.uses ?? 1}"></label>
                       <label class="field">${esc(A.useTime)}<input class="input" type="number" min="0.5" max="60" step="0.5" ${bind("use_time", "ms")} value="${d.use_time ? d.use_time / 1000 : ""}" placeholder="${anim.useTime ? anim.useTime / 1000 : "-"}"></label>
                       <div class="hint span2">${esc(A.usesHint)}. ${esc(A.useTimeHint)}</div>
                       <div class="banner span4">${esc(A.perUseHint)}</div>`
                    : ""
            }
        </div>
        ${anim.interaction || anim.none ? "" : `<div class="hint">${esc(A.propHint)}</div>`}
        ${propHtml(d, anim)}`,
        `<button class="btn btn--small framed" data-act="preview" data-kind="consumable">&#9654; ${esc(A.preview)}</button>`
    );

    const effectGroup = group(
        A.effect,
        "",
        `<div class="form-grid">
            <label class="field span2">${esc(A.effect)}<select class="input" ${bind("effect", "id")} data-rerender="1">
                <option value="">${esc(A.none)}</option>
                ${effects.map((e) => `<option value="${e.id}" ${d.effect === e.id ? "selected" : ""}>${esc(e.label)}${e.enabled ? "" : ` (${esc(A.off)})`}</option>`).join("")}
            </select></label>
            ${
                effect
                    ? `<label class="field span2">${esc(A.effectTime)} <span class="hint">${esc(A.effectTimeHint)}</span><input class="input" type="number" min="1" ${bind("effect_time", "int")} value="${d.effect_time ?? ""}" placeholder="${effect.duration || D.defaults.effectTime}"></label>`
                    : ""
            }
            <div class="field">${esc(A.clearEffects)}${toggleHtml("clear_effects", d.clear_effects)}</div>
            <div class="field">${esc(A.sober)}${toggleHtml("sober", d.sober)}</div>
            <label class="field span2">${esc(A.cooldown)} <span class="hint">${esc(A.cooldownHint)}</span><input class="input" type="number" min="0" ${bind("cooldown", "int")} value="${d.cooldown || ""}" placeholder="0"></label>
        </div>`,
        effect ? `<button class="btn btn--small framed" data-act="preview" data-kind="effect">&#9654; ${esc(A.preview)}</button>` : ""
    );

    // Item rows: what it gives back, and what the player needs to have (kept)
    const stackGroup = (path, title, hint) =>
        group(
            title,
            hint,
            d[path]
                .map(
                    (g, i) => `<div class="stack-row stack-row--gives">
                ${img(g.name, itemLabel(g.name), "thumb--s")}
                ${pickerHtml(`${path}.${i}.name`, g.name, "items", A.itemPlaceholder)}
                <input class="input" type="number" min="1" ${bind(`${path}.${i}.count`, "int")} value="${g.count ?? 1}">
                <button class="icon-btn" data-act="rowRemove" data-path="${path}" data-i="${i}">&#x2715;</button>
            </div>`
                )
                .join(""),
            `<button class="btn btn--small framed" data-act="rowAdd" data-path="${path}">+ ${esc(A.addRow)}</button>`
        );
    const gives = stackGroup("gives", A.gives, A.givesHint);
    const requires = stackGroup("requires", A.requires, A.requiresHint);

    return `<div class="editor">
        <div id="editorHead" class="editor__head">${consumableHeadHtml(d)}</div>
        ${d.updated_by ? `<div class="hint">${esc(fmt(A.updatedBy, d.updated_by))}</div>` : ""}
        <div class="form-grid">
            <div class="field span2">${esc(A.item)}${pickerHtml("item", d.item, "items", A.itemPlaceholder)}</div>
            <label class="field">${esc(A.kind)}<select class="input" ${bind("kind")}>${D.kinds
                .map((k) => `<option value="${esc(k.key)}" ${d.kind === k.key ? "selected" : ""}>${esc(k.label)}</option>`)
                .join("")}</select></label>
            <div class="field">${esc(A.enabled)}${toggleHtml("enabled", d.enabled)}</div>
        </div>
        ${status}${cores}${animation}${effectGroup}${requires}${gives}
        ${actionsHtml(d, true)}
    </div>`;
}

function effectEditorHtml(d) {
    const A = S.A;
    const D = S.data;
    return `<div class="editor">
        <div class="row row--between"><h2>${esc(d.label || A.newEffect)}</h2>${d.id ? `<span class="dim">#${d.id} · ${esc(fmt(A.usedBy, usedBy(d.id)))}</span>` : ""}</div>
        <div class="form-grid">
            <label class="field span2">${esc(A.label)}<input class="input" ${bind("label")} value="${esc(d.label)}" maxlength="64"></label>
            <label class="field">${esc(A.duration)}<input class="input" type="number" min="1" ${bind("duration", "int")} value="${d.duration ?? ""}" placeholder="${D.defaults.effectTime}"></label>
            <div class="field">${esc(A.enabled)}${toggleHtml("enabled", d.enabled)}</div>
            <div class="hint span4">${esc(A.durationHint)}</div>
        </div>
        ${group(
            A.screen,
            "",
            `<div class="form-grid">
                <div class="field span4">${esc(A.postfx)} <span class="hint">${esc(A.postfxHint)}</span>${chipsHtml("postfx", d.postfx, A.effectPlaceholder, "screenEffects")}</div>
                <div class="field span2">${esc(A.startFx)} <span class="hint">${esc(A.oneShotHint)}</span>${pickerHtml("start_fx", d.start_fx, "screenEffects", A.none, false)}</div>
                <div class="field span2">${esc(A.endFx)} <span class="hint">${esc(A.oneShotHint)}</span>${pickerHtml("end_fx", d.end_fx, "screenEffects", A.none, false)}</div>
                <div class="field span2">${esc(A.timecycle)}${pickerHtml("timecycle", d.timecycle, "timecycles", A.none, false)}</div>
                ${sliderHtml(A.strength, "strength", d.strength, { kind: "effects" })}
            </div>`
        )}
        ${group(
            A.body,
            "",
            `<div class="form-grid">
                ${sliderHtml(A.drunk, "drunk", d.drunk, { kind: "effects", hint: A.drunkHint })}
                <div class="field span2">${esc(A.blur)}${toggleHtml("blur", d.blur)}</div>
                <label class="field span2">${esc(A.shake)}<select class="input" ${bind("shake")}>
                    <option value="">${esc(A.none)}</option>
                    ${[...new Set([...D.lists.shakes, ...(d.shake ? [d.shake] : [])])].map((s) => `<option value="${esc(s)}" ${d.shake === s ? "selected" : ""}>${esc(s)}</option>`).join("")}
                </select></label>
                ${sliderHtml(A.shakeAmount, "shake_amount", d.shake_amount, { kind: "effects" })}
                <label class="field span2">${esc(A.shakeTime)} <span class="hint">${esc(A.shakeTimeHint)}</span><input class="input" type="number" step="1" min="0" ${bind("shake_time", "int")} value="${d.shake_time ?? 0}"></label>
            </div>`
        )}
        <div class="row"><button class="btn framed" data-act="preview" data-kind="effect">&#9654; ${esc(A.preview)}</button></div>
        ${actionsHtml(d, true)}
    </div>`;
}

function editorHtml() {
    const d = AD.draft;
    if (!d) return `<div class="empty">${esc(S.A.pickSomething)}</div>`;
    return AD.tab === "consumables" ? consumableEditorHtml(d) : effectEditorHtml(d);
}

function render() {
    if (!S.open || !S.data) return;
    const A = S.A;
    const D = S.data;
    $("title").textContent = A.title;
    $("headLeft").innerHTML = `<span class="subtitle">${esc(fmt(A.counts, D.consumables.size, D.effects.size))}</span>`;
    $("tabs").innerHTML = ["consumables", "effects"]
        .map((t) => `<button class="tab framed ${t === AD.tab ? "active" : ""}" data-act="tab" data-tab="${t}">${esc(A.tabs[t])}</button>`)
        .join("");
    const list = adminListHtml();
    keepScroll(() => {
        $("body").innerHTML = `<div class="cols cols--admin">
            <div class="col">${listHeadHtml()}<div id="aList" class="scroll grow list" data-scroll="alist">${list.rows}</div><div id="aPager">${list.pager}</div></div>
            <div id="editor" class="col scroll" data-scroll="editor">${editorHtml()}</div>
        </div>`;
    });
    paintSliders();
}

function renderList() {
    const el = $("aList");
    if (!el) return;
    const list = adminListHtml();
    keepScroll(() => (el.innerHTML = list.rows));
    $("aPager").innerHTML = list.pager;
}

function renderEditor(focusSelector) {
    const el = $("editor");
    if (!el) return;
    keepScroll(() => (el.innerHTML = editorHtml()));
    paintSliders();
    if (focusSelector) {
        const target = el.querySelector(focusSelector);
        if (target) target.focus();
    }
}

// ---------------------------------------------------------------- Editing the draft

function setPath(obj, path, value) {
    const parts = path.split(".");
    let target = obj;
    for (let i = 0; i < parts.length - 1; i++) {
        const key = /^\d+$/.test(parts[i]) ? Number(parts[i]) : parts[i];
        if (target[key] === null || target[key] === undefined) target[key] = {};
        target = target[key];
    }
    target[parts[parts.length - 1]] = value;
}

function getPath(obj, path) {
    return path.split(".").reduce((o, k) => (o === null || o === undefined ? undefined : o[/^\d+$/.test(k) ? Number(k) : k]), obj);
}

function markDirty() {
    AD.dirty = true;
    AD.leaveKey = null;
    if (AD.confirm) {
        AD.confirm = false;
        const btn = document.querySelector('[data-act="delete"]');
        if (btn) {
            btn.classList.remove("btn--confirm");
            btn.classList.add("btn--danger");
            btn.textContent = S.A.delete;
        }
    }
}

function applyBind(el) {
    let value;
    switch (el.dataset.type) {
        case "int":
            value = el.value === "" ? null : Math.floor(Number(el.value));
            if (!Number.isFinite(value)) value = null;
            break;
        case "float":
            value = el.value === "" ? null : Number(el.value);
            if (!Number.isFinite(value)) value = null;
            break;
        case "ms": // typed in seconds, kept in ms
            value = el.value === "" ? null : Math.round(Number(el.value) * 1000);
            if (!Number.isFinite(value)) value = null;
            break;
        case "id":
            value = el.value === "" ? null : Number(el.value);
            break;
        default:
            value = el.value;
    }
    setPath(AD.draft, el.dataset.bind, value);
    markDirty();
}

/** Updates the label and picture next to an item name as it is typed */
function updatePreview(input) {
    if (input.dataset.picker !== "items") return;
    const info = itemInfo(input.value);
    input.classList.toggle("input--bad", !!input.value && !info);
    const preview = input.parentElement.querySelector(".label-preview");
    if (preview) {
        preview.textContent = input.value ? (info ? info.label : S.A.unknownItem) : "";
        preview.classList.toggle("bad", !!input.value && !info);
    }
    const row = input.closest(".stack-row");
    const thumb = row && row.querySelector(".thumb");
    if (thumb) thumb.outerHTML = img(input.value, info ? info.label : input.value, "thumb--s");
}

/** Up to 40 matches: starting with what is typed first, then containing it */
function pickerOptions(source, query, skip = []) {
    const q = query.trim().toLowerCase();
    const items = source === "items";
    const list = items ? S.data.items : (S.data.lists[source] || []).map((name) => ({ name, label: name }));
    const starts = [];
    const contains = [];
    for (const o of list) {
        if (skip.includes(o.name)) continue;
        const name = String(o.name).toLowerCase();
        const label = String(o.label).toLowerCase();
        if (!q || name.startsWith(q) || label.startsWith(q)) starts.push(o);
        else if (name.includes(q) || label.includes(q)) contains.push(o);
        if (starts.length >= 40) break;
    }
    return { options: starts.concat(contains).slice(0, 40), items };
}

function showOptions(input, options, items, attr) {
    const list = input.parentElement.querySelector(".picker__list");
    if (!list) return;
    if (!options.length) return list.classList.add("hidden");
    list.innerHTML = options
        .map((o) => `<button class="picker__opt" ${attr}="${esc(o.name)}">${items ? img(o.name, o.label, "thumb--xs") : ""}<span>${esc(o.label)}</span>${items ? `<small>${esc(o.name)}</small>` : ""}</button>`)
        .join("");
    list.classList.remove("hidden");
}

function openPicker(input) {
    if (input.dataset.picker === "none") return;
    const { options, items } = pickerOptions(input.dataset.picker, input.value);
    showOptions(input, options, items, "data-pick");
}

function openSuggest(input) {
    const have = getPath(AD.draft, input.dataset.chip) || [];
    const { options } = pickerOptions(input.dataset.source, input.value, have);
    showOptions(input, options, false, "data-suggest-pick");
}

function closePickers() {
    let closed = false;
    document.querySelectorAll(".picker__list:not(.hidden)").forEach((list) => {
        list.classList.add("hidden");
        closed = true;
    });
    return closed;
}

function pick(input, name) {
    input.value = name;
    applyBind(input);
    updatePreview(input);
    closePickers();
    if (input.dataset.bind === "item") updateHead();
}

/** Adds what is typed in a chip input */
function addChips(input) {
    const path = input.dataset.chip;
    const list = getPath(AD.draft, path) || [];
    let added = false;
    for (let part of input.value.split(/[,\s]+/)) {
        part = part.trim();
        if (part && !list.includes(part)) {
            list.push(part);
            added = true;
        }
    }
    input.value = "";
    if (added) {
        setPath(AD.draft, path, list);
        markDirty();
    }
    return added;
}

function pickSuggestion(input, name) {
    input.value = name;
    addChips(input);
    renderEditor(`[data-chip="${input.dataset.chip}"]`);
}

/** Anything typed but not yet turned into a chip is kept on save */
function flushChips() {
    document.querySelectorAll("[data-chip]").forEach((input) => {
        if (input.value.trim()) addChips(input);
    });
}

const blankText = (v) => (typeof v === "string" && v.trim() ? v.trim() : null);

function vectorOf(v) {
    if (!v) return null;
    const x = v.x ?? null, y = v.y ?? null, z = v.z ?? null;
    if (x === null && y === null && z === null) return null;
    return { x: x ?? 0, y: y ?? 0, z: z ?? 0 };
}

function propOf(prop) {
    if (!prop) return null;
    const out = { model: blankText(prop.model), bone: blankText(prop.bone), offset: vectorOf(prop.offset), rotation: vectorOf(prop.rotation) };
    return out.model || out.bone || out.offset || out.rotation ? out : null;
}

function payloadOf(kind, d) {
    if (kind === "effects") {
        return {
            id: d.id, label: d.label, duration: d.duration, postfx: d.postfx, start_fx: blankText(d.start_fx), end_fx: blankText(d.end_fx),
            timecycle: blankText(d.timecycle), strength: d.strength, drunk: d.drunk, shake: blankText(d.shake), shake_amount: d.shake_amount,
            shake_time: d.shake_time, blur: d.blur, enabled: d.enabled,
        };
    }
    const out = clone(d);
    delete out.updated_by;
    delete out.updated_at;
    out.item = blankText(d.item);
    out.interaction = blankText(d.interaction);
    out.prop = propOf(d.prop);
    out.requires = d.requires.filter((g) => g.name && g.name.trim()).map((g) => ({ name: g.name.trim(), count: g.count || 1 }));
    out.gives = d.gives.filter((g) => g.name && g.name.trim()).map((g) => ({ name: g.name.trim(), count: g.count || 1 }));
    return out;
}

/** What the preview plays: a consumable's animation (then its effect), or an effect on its own */
function previewPayload(kind) {
    const d = AD.draft;
    const D = S.data;
    if (AD.tab === "effects") {
        const e = payloadOf("effects", d);
        return { kind: "effect", label: d.label, effect: e, seconds: d.duration || D.defaults.effectTime };
    }
    const effect = d.effect && D.effects.get(d.effect);
    const seconds = d.effect_time || (effect && effect.duration) || D.defaults.effectTime;
    if (kind === "effect") return effect ? { kind: "effect", label: effect.label, effect, seconds } : null;
    return {
        kind: "consumable", label: d.item ? itemLabel(d.item) : S.A.newConsumable, animation: animationOf(d.animation).key,
        interaction: blankText(d.interaction), prop: propOf(d.prop), effect: effect || null, seconds, uses: d.uses || 1, use_time: d.use_time,
    };
}

/** Unsaved changes: the first try only warns */
function canLeave(key) {
    if (!AD.dirty || AD.leaveKey === key) {
        AD.leaveKey = null;
        return true;
    }
    AD.leaveKey = key;
    toast(S.A.unsaved, false);
    return false;
}

function selectRow(kind, id) {
    AD.sel[kind] = id;
    const row = id !== null && id !== "new" ? S.data[kind].get(id) : null;
    AD.draft = row ? clone(row) : id === "new" ? blankRow(kind) : null;
    AD.dirty = false;
    AD.confirm = false;
}

const clicks = {
    close() {
        if (canLeave("close")) closeApp();
    },
    tab(el) {
        const tab = el.dataset.tab;
        if (tab === AD.tab || !canLeave("tab:" + tab)) return;
        AD.tab = tab;
        const keep = AD.sel[tab];
        selectRow(tab, keep !== null && keep !== "new" && S.data[tab].has(keep) ? keep : null);
        sound("button", 0.2);
        render();
    },
    pick(el) {
        const id = Number(el.dataset.id);
        if (AD.sel[AD.tab] === id || !canLeave("pick:" + id)) return;
        selectRow(AD.tab, id);
        sound("button", 0.2);
        document.querySelectorAll(".list-row.active").forEach((x) => x.classList.remove("active"));
        el.classList.add("active");
        renderEditor();
    },
    new() {
        if (!canLeave("new")) return;
        selectRow(AD.tab, "new");
        renderList();
        renderEditor(AD.tab === "consumables" ? '[data-bind="item"]' : '[data-bind="label"]');
    },
    page(el) {
        AD.page[AD.tab] = Number(el.dataset.page);
        sound("button", 0.2);
        renderList();
        $("aList").scrollTop = 0;
    },
    toggle(el) {
        const path = el.dataset.path;
        const on = !getPath(AD.draft, path);
        setPath(AD.draft, path, on);
        el.classList.toggle("on", on);
        markDirty();
    },
    chipRemove(el) {
        const list = getPath(AD.draft, el.dataset.path) || [];
        list.splice(Number(el.dataset.i), 1);
        markDirty();
        renderEditor();
    },
    rowAdd(el) {
        const list = getPath(AD.draft, el.dataset.path);
        list.push({ name: "", count: 1 });
        markDirty();
        renderEditor(`[data-bind="${el.dataset.path}.${list.length - 1}.name"]`);
    },
    rowRemove(el) {
        getPath(AD.draft, el.dataset.path).splice(Number(el.dataset.i), 1);
        markDirty();
        renderEditor();
    },
    preview(el) {
        if (!AD.draft) return;
        flushChips();
        const payload = previewPayload(el.dataset.kind);
        if (!payload) return;
        closePickers();
        sound("button", 0.2);
        post("preview", payload).catch(() => {});
    },
    save() {
        if (!AD.draft) return;
        flushChips();
        sound("selected", 0.3);
        adminPost(AD.tab === "consumables" ? "saveConsumable" : "saveEffect", payloadOf(AD.tab, AD.draft));
    },
    duplicate() {
        if (!AD.draft) return;
        const copy = clone(AD.draft);
        copy.id = null;
        delete copy.updated_by;
        // An item can only be one consumable, so the copy needs a new one
        if (AD.tab === "consumables") copy.item = "";
        else copy.label = `${copy.label} 2`.slice(0, 64);
        AD.sel[AD.tab] = "new";
        AD.draft = copy;
        AD.dirty = true;
        AD.confirm = false;
        renderList();
        renderEditor(AD.tab === "consumables" ? '[data-bind="item"]' : '[data-bind="label"]');
    },
    revert() {
        selectRow(AD.tab, AD.sel[AD.tab]);
        renderEditor();
    },
    delete() {
        if (!AD.draft || !AD.draft.id) return;
        if (!AD.confirm) {
            AD.confirm = true;
            renderEditor();
            return;
        }
        AD.confirm = false;
        adminPost(AD.tab === "consumables" ? "deleteConsumable" : "deleteEffect", AD.draft.id);
    },
};

function applyPatch(patch, select) {
    const D = S.data;
    for (const kind of ["consumables", "effects"]) {
        for (const row of arr(patch[kind])) D[kind].set(row.id, normalizeRow(kind, row));
        for (const id of patch.removed ? arr(patch.removed[kind]) : []) {
            D[kind].delete(id);
            if (AD.sel[kind] === id) {
                AD.sel[kind] = null;
                if (AD.tab === kind) {
                    AD.draft = null;
                    AD.dirty = false;
                }
            }
        }
    }
    if (select) {
        AD.sel[select.kind] = select.id;
        revealRow(select.kind, select.id);
        if (AD.tab === select.kind) {
            AD.draft = clone(D[select.kind].get(select.id));
            AD.dirty = false;
            AD.confirm = false;
        }
    } else if (AD.draft && AD.draft.id && !AD.dirty) {
        // Someone else changed what is open here: show their version
        const row = D[AD.tab].get(AD.draft.id);
        if (row) AD.draft = clone(row);
    }
    renderSoon();
}

// ---------------------------------------------------------------- Preview bar

let previewTimer = null;
function previewBar(data) {
    const bar = $("previewBar");
    clearInterval(previewTimer);
    if (!data.text) return bar.classList.add("hidden");
    bar.innerHTML = `<span class="previewbar__title">${esc(data.text)}</span><span id="previewTime" class="previewbar__time"></span><span class="previewbar__key"><span class="key">BACKSPACE</span>${esc(data.key)}</span>`;
    bar.classList.remove("hidden");
    if (data.seconds) {
        const ends = Date.now() + data.seconds * 1000;
        const tick = () => {
            const el = $("previewTime");
            if (el) el.textContent = `${Math.max(0, Math.ceil((ends - Date.now()) / 1000))}s`;
        };
        tick();
        previewTimer = setInterval(tick, 250);
    }
}

// ================================================================ Events

document.addEventListener("click", (e) => {
    const el = e.target.closest("[data-act]");
    if (!el || el.disabled) return;
    const fn = clicks[el.dataset.act];
    if (fn) fn(el);
});

// Picker options are chosen on mousedown, before the input loses focus
document.addEventListener("mousedown", (e) => {
    const suggestion = e.target.closest("[data-suggest-pick]");
    if (suggestion) {
        e.preventDefault();
        pickSuggestion(suggestion.closest(".chips").querySelector("[data-chip]"), suggestion.dataset.suggestPick);
        return;
    }
    const opt = e.target.closest("[data-pick]");
    if (!opt) return;
    e.preventDefault();
    pick(opt.closest(".picker").querySelector("input"), opt.dataset.pick);
});

document.addEventListener("input", (e) => {
    const t = e.target;
    if (!S.open) return;
    if (t.dataset.bind && t.tagName !== "SELECT") {
        applyBind(t);
        if (t.dataset.picker) {
            updatePreview(t);
            openPicker(t);
        }
        if (t.dataset.bind === "item") updateHead();
        if (t.dataset.slider) syncSlider(t);
    } else if (t.dataset.chip) {
        openSuggest(t);
    } else if (t.id === "aSearch") {
        AD.filters[AD.tab].search = t.value;
        AD.page[AD.tab] = 1;
        renderList();
    }
});

document.addEventListener("change", (e) => {
    const t = e.target;
    if (!S.open) return;
    if (t.dataset.bind && t.tagName === "SELECT") {
        applyBind(t);
        if (t.dataset.rerender) renderEditor();
    } else if (t.dataset.slider && t.type === "number") {
        clampSlider(t);
    } else if (t.id === "aKind") {
        AD.filters.consumables.kind = t.value;
        AD.page.consumables = 1;
        renderList();
    }
});

document.addEventListener("focusin", (e) => {
    const t = e.target;
    if (!S.open || !t.dataset) return;
    if (t.dataset.picker) openPicker(t);
    if (t.dataset.chip) openSuggest(t);
});

document.addEventListener("focusout", (e) => {
    const t = e.target;
    if (t.dataset && (t.dataset.picker || t.dataset.chip))
        setTimeout(() => {
            const list = t.parentElement && t.parentElement.querySelector(".picker__list");
            if (list && document.activeElement !== t) list.classList.add("hidden");
        }, 120);
});

/** Arrow keys move through an open dropdown, Enter picks. Returns true if the key was used */
function dropdownKeys(e, input, attr, onPick) {
    const list = input.parentElement.querySelector(".picker__list:not(.hidden)");
    const opts = list ? [...list.querySelectorAll(`[${attr}]`)] : [];
    if (!opts.length) return false;
    const at = opts.findIndex((o) => o.classList.contains("active"));
    if (e.key === "ArrowDown" || e.key === "ArrowUp") {
        e.preventDefault();
        const next = Math.max(0, Math.min(opts.length - 1, at + (e.key === "ArrowDown" ? 1 : -1)));
        opts.forEach((o, i) => o.classList.toggle("active", i === next));
        opts[next].scrollIntoView({ block: "nearest" });
        return true;
    }
    if (e.key === "Enter" && (at >= 0 || attr === "data-pick")) {
        e.preventDefault();
        onPick(opts[Math.max(0, at)].getAttribute(attr));
        return true;
    }
    return false;
}

document.addEventListener("keydown", (e) => {
    if (!S.open) return;
    const t = e.target;
    if (t.dataset && t.dataset.picker && t.dataset.picker !== "none" && dropdownKeys(e, t, "data-pick", (name) => pick(t, name))) return;
    if (t.dataset && t.dataset.chip) {
        if (dropdownKeys(e, t, "data-suggest-pick", (name) => pickSuggestion(t, name))) return;
        if (e.key === "Enter" || e.key === ",") {
            e.preventDefault();
            if (addChips(t)) renderEditor(`[data-chip="${t.dataset.chip}"]`);
            return;
        }
        if (e.key === "Backspace" && t.value === "") {
            const list = getPath(AD.draft, t.dataset.chip) || [];
            if (list.length) {
                list.pop();
                markDirty();
                renderEditor(`[data-chip="${t.dataset.chip}"]`);
            }
            return;
        }
    }
    if (e.key === "Escape") {
        if (closePickers()) return;
        clicks.close();
    }
});

// ---------------------------------------------------------------- Messages from Lua

window.addEventListener("message", (e) => {
    const data = e.data || {};
    switch (data.action) {
        case "admin":
            S.settings = data.settings || {};
            S.A = data.lang || {};
            if (!setAdminData(data.data || {})) break; // everything is on its way again
            for (const kind of ["consumables", "effects"]) {
                if (AD.sel[kind] !== null && AD.sel[kind] !== "new" && !S.data[kind].has(AD.sel[kind])) AD.sel[kind] = null;
            }
            selectRow(AD.tab, AD.sel[AD.tab] === "new" ? null : AD.sel[AD.tab]);
            S.open = true;
            $("app").classList.remove("hidden");
            render();
            sound("menu_open", 0.3);
            break;
        case "adminPatch":
            if (S.data) applyPatch(data.patch || {}, data.select);
            break;
        case "toast":
            if (data.ok === true) sound("selected", 0.25);
            toast(data.text, data.ok);
            break;
        case "hide":
            $("app").classList.add("hidden");
            break;
        case "show":
            if (!S.open) return;
            $("app").classList.remove("hidden");
            break;
        case "previewBar":
            previewBar(data);
            break;
        case "close":
            closeApp(false);
            break;
    }
});
