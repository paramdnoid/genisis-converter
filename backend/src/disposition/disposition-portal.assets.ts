export const DISPOSITION_PORTAL_HTML = `<!doctype html>
<html lang="de">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Kaminfeger Disposition</title>
    <link rel="stylesheet" href="/disposition/app.css" />
  </head>
  <body>
    <main class="shell">
      <section class="topbar">
        <div>
          <p class="eyebrow">Kaminfeger Mobile</p>
          <h1>Disposition</h1>
        </div>
        <button id="refreshButton" class="ghost" type="button">Aktualisieren</button>
      </section>

      <section id="loginPanel" class="panel login-panel">
        <h2>Backend anmelden</h2>
        <form id="loginForm" class="login-grid">
          <label>
            E-Mail
            <input id="emailInput" type="email" autocomplete="username" value="admin@example.invalid" required />
          </label>
          <label>
            Passwort
            <input id="passwordInput" type="password" autocomplete="current-password" value="admin1234" required />
          </label>
          <button type="submit">Anmelden</button>
        </form>
        <p id="loginMessage" class="message"></p>
      </section>

      <section id="portalPanel" class="portal hidden">
        <div class="metrics" id="metrics"></div>
        <section class="layout">
          <aside class="panel filters">
            <h2>Filter</h2>
            <label>
              Status
              <select id="statusFilter">
                <option value="">Alle Status</option>
                <option value="scheduled">Geplant</option>
                <option value="in_progress">In Arbeit</option>
                <option value="paused">Pausiert</option>
                <option value="completed">Erledigt</option>
                <option value="cancelled">Abgesagt</option>
              </select>
            </label>
            <label>
              Techniker
              <select id="technicianFilter"></select>
            </label>
            <label>
              Suche
              <input id="searchInput" type="search" placeholder="Auftrag, Kunde, Ort" />
            </label>
            <div class="sync-note" id="syncNote"></div>
          </aside>

          <section class="panel work-orders">
            <div class="section-title">
              <h2>Aufträge</h2>
              <span id="resultCount"></span>
            </div>
            <div id="workOrderList" class="work-order-list"></div>
          </section>
        </section>
      </section>
    </main>
    <script src="/disposition/app.js" defer></script>
  </body>
</html>`;

export const DISPOSITION_PORTAL_CSS = `:root {
  color-scheme: light;
  --bg: #f6f7f4;
  --panel: #ffffff;
  --text: #1d261f;
  --muted: #667067;
  --line: #d9dfd7;
  --accent: #176b4d;
  --accent-2: #9a6122;
  --danger: #b42318;
  --shadow: 0 12px 30px rgba(27, 39, 31, 0.08);
}

* {
  box-sizing: border-box;
}

body {
  margin: 0;
  min-height: 100vh;
  background: var(--bg);
  color: var(--text);
  font-family: Inter, ui-sans-serif, system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
}

button,
input,
select {
  font: inherit;
}

button {
  border: 0;
  border-radius: 6px;
  background: var(--accent);
  color: #fff;
  min-height: 42px;
  padding: 0 14px;
  font-weight: 700;
  cursor: pointer;
}

button:disabled {
  opacity: 0.55;
  cursor: wait;
}

button.ghost {
  background: #e6eee9;
  color: var(--accent);
}

.shell {
  width: min(1180px, calc(100vw - 32px));
  margin: 0 auto;
  padding: 28px 0 48px;
}

.topbar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 18px;
  margin-bottom: 18px;
}

.eyebrow {
  margin: 0 0 4px;
  color: var(--accent);
  font-size: 0.78rem;
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 0;
}

h1,
h2,
h3,
p {
  margin-top: 0;
}

h1 {
  margin-bottom: 0;
  font-size: 2rem;
}

h2 {
  font-size: 1.1rem;
}

.panel,
.metric,
.work-order {
  background: var(--panel);
  border: 1px solid var(--line);
  border-radius: 8px;
  box-shadow: var(--shadow);
}

.panel {
  padding: 18px;
}

.hidden {
  display: none !important;
}

.login-grid {
  display: grid;
  grid-template-columns: minmax(220px, 1fr) minmax(220px, 1fr) auto;
  gap: 12px;
  align-items: end;
}

label {
  display: grid;
  gap: 6px;
  color: var(--muted);
  font-size: 0.9rem;
  font-weight: 700;
}

input,
select {
  width: 100%;
  border: 1px solid var(--line);
  border-radius: 6px;
  background: #fff;
  color: var(--text);
  min-height: 42px;
  padding: 0 11px;
}

.message {
  min-height: 20px;
  margin: 12px 0 0;
  color: var(--danger);
  font-weight: 700;
}

.portal {
  display: grid;
  gap: 18px;
}

.metrics {
  display: grid;
  grid-template-columns: repeat(6, minmax(120px, 1fr));
  gap: 12px;
}

.metric {
  padding: 14px;
}

.metric strong {
  display: block;
  font-size: 1.65rem;
}

.metric span {
  color: var(--muted);
  font-size: 0.88rem;
  font-weight: 700;
}

.layout {
  display: grid;
  grid-template-columns: 280px 1fr;
  gap: 18px;
  align-items: start;
}

.filters {
  display: grid;
  gap: 14px;
}

.sync-note {
  color: var(--muted);
  font-size: 0.86rem;
}

.section-title {
  display: flex;
  align-items: baseline;
  justify-content: space-between;
  gap: 12px;
  margin-bottom: 12px;
}

.section-title h2 {
  margin-bottom: 0;
}

.section-title span {
  color: var(--muted);
  font-weight: 700;
}

.work-order-list {
  display: grid;
  gap: 12px;
}

.work-order {
  display: grid;
  grid-template-columns: 1fr 220px;
  gap: 14px;
  padding: 14px;
}

.work-order h3 {
  margin-bottom: 6px;
  font-size: 1.05rem;
}

.meta {
  color: var(--muted);
  display: flex;
  flex-wrap: wrap;
  gap: 8px;
  font-size: 0.88rem;
}

.badges {
  display: flex;
  flex-wrap: wrap;
  gap: 6px;
  margin-top: 10px;
}

.badge {
  border-radius: 999px;
  background: #edf1ec;
  color: var(--text);
  padding: 4px 8px;
  font-size: 0.78rem;
  font-weight: 800;
}

.badge.overdue {
  background: #fff0ed;
  color: var(--danger);
}

.dispatch-form {
  display: grid;
  gap: 8px;
}

.empty {
  padding: 24px;
  color: var(--muted);
  text-align: center;
}

@media (max-width: 900px) {
  .metrics,
  .layout,
  .login-grid,
  .work-order {
    grid-template-columns: 1fr;
  }

  .topbar {
    align-items: stretch;
    flex-direction: column;
  }
}`;

export const DISPOSITION_PORTAL_JS = `const state = {
  token: localStorage.getItem("kaminfeger.disposition.token") || "",
  snapshot: null,
};

const labels = {
  scheduled: "Geplant",
  in_progress: "In Arbeit",
  paused: "Pausiert",
  completed: "Erledigt",
  cancelled: "Abgesagt",
  low: "Niedrig",
  normal: "Normal",
  high: "Hoch",
  urgent: "Dringend",
};

const qs = (selector) => document.querySelector(selector);

document.addEventListener("DOMContentLoaded", () => {
  qs("#loginForm").addEventListener("submit", login);
  qs("#refreshButton").addEventListener("click", loadSnapshot);
  qs("#statusFilter").addEventListener("change", renderWorkOrders);
  qs("#technicianFilter").addEventListener("change", renderWorkOrders);
  qs("#searchInput").addEventListener("input", renderWorkOrders);

  if (state.token) {
    loadSnapshot();
  }
});

async function login(event) {
  event.preventDefault();
  setLoginMessage("");
  const response = await fetch("/auth/login", {
    method: "POST",
    headers: { "content-type": "application/json" },
    body: JSON.stringify({
      email: qs("#emailInput").value,
      password: qs("#passwordInput").value,
    }),
  });

  if (!response.ok) {
    setLoginMessage("Anmeldung fehlgeschlagen.");
    return;
  }

  const payload = await response.json();
  state.token = payload.tokens.accessToken;
  localStorage.setItem("kaminfeger.disposition.token", state.token);
  await loadSnapshot();
}

async function loadSnapshot() {
  if (!state.token) {
    showLogin();
    return;
  }

  const response = await fetch("/disposition/api/snapshot", {
    headers: { authorization: "Bearer " + state.token },
  });

  if (response.status === 401 || response.status === 403) {
    localStorage.removeItem("kaminfeger.disposition.token");
    state.token = "";
    showLogin();
    setLoginMessage("Bitte mit einem Admin- oder Disponenten-Konto anmelden.");
    return;
  }

  if (!response.ok) {
    setLoginMessage("Disposition konnte nicht geladen werden.");
    return;
  }

  state.snapshot = await response.json();
  qs("#loginPanel").classList.add("hidden");
  qs("#portalPanel").classList.remove("hidden");
  renderMetrics();
  renderTechnicianFilter();
  renderWorkOrders();
}

function showLogin() {
  qs("#loginPanel").classList.remove("hidden");
  qs("#portalPanel").classList.add("hidden");
}

function renderMetrics() {
  const metrics = state.snapshot.metrics;
  qs("#metrics").innerHTML = [
    ["total", "Total"],
    ["open", "Offen"],
    ["scheduled", "Geplant"],
    ["inProgress", "In Arbeit"],
    ["overdue", "Überfällig"],
    ["unassigned", "Unzugewiesen"],
  ]
    .map(([key, label]) => '<article class="metric"><strong>' + metrics[key] + '</strong><span>' + label + '</span></article>')
    .join("");
  qs("#syncNote").textContent =
    "Stand " + new Date(state.snapshot.generatedAt).toLocaleString("de-CH");
}

function renderTechnicianFilter() {
  const select = qs("#technicianFilter");
  const current = select.value;
  select.innerHTML =
    '<option value="">Alle Techniker</option><option value="__unassigned">Unzugewiesen</option>' +
    state.snapshot.technicians
      .map((technician) => '<option value="' + escapeHtml(technician.id) + '">' + escapeHtml(technician.name) + '</option>')
      .join("");
  select.value = current;
}

function renderWorkOrders() {
  if (!state.snapshot) return;
  const status = qs("#statusFilter").value;
  const technician = qs("#technicianFilter").value;
  const search = qs("#searchInput").value.trim().toLowerCase();
  const items = state.snapshot.workOrders.filter((workOrder) => {
    if (status && workOrder.status !== status) return false;
    if (technician === "__unassigned" && workOrder.assignedUserId) return false;
    if (technician && technician !== "__unassigned" && workOrder.assignedUserId !== technician) return false;
    if (search) {
      const haystack = [
        workOrder.orderNumber,
        workOrder.title,
        workOrder.customerName,
        workOrder.objectName,
        workOrder.address,
      ]
        .join(" ")
        .toLowerCase();
      return haystack.includes(search);
    }
    return true;
  });

  qs("#resultCount").textContent = items.length + " Treffer";
  qs("#workOrderList").innerHTML =
    items.length === 0
      ? '<div class="empty">Keine passenden Aufträge.</div>'
      : items.map(renderWorkOrder).join("");

  document.querySelectorAll("[data-dispatch-form]").forEach((form) => {
    form.addEventListener("submit", updateWorkOrder);
  });
}

function renderWorkOrder(workOrder) {
  const technicians = [
    '<option value="">Unzugewiesen</option>',
    ...state.snapshot.technicians.map(
      (technician) =>
        '<option value="' +
        escapeHtml(technician.id) +
        '"' +
        (technician.id === workOrder.assignedUserId ? " selected" : "") +
        ">" +
        escapeHtml(technician.name) +
        "</option>",
    ),
  ].join("");

  return (
    '<article class="work-order">' +
    '<div>' +
    '<h3>' +
    escapeHtml(workOrder.orderNumber + " · " + workOrder.title) +
    "</h3>" +
    '<div class="meta"><span>' +
    escapeHtml(formatDate(workOrder.scheduledStart)) +
    "</span><span>" +
    escapeHtml(workOrder.customerName) +
    "</span><span>" +
    escapeHtml(workOrder.address) +
    "</span></div>" +
    '<div class="badges">' +
    badge(labels[workOrder.status] || workOrder.status, workOrder.isOverdue ? "overdue" : "") +
    badge(labels[workOrder.priority] || workOrder.priority, "") +
    badge(workOrder.assignedUserName || "Unzugewiesen", workOrder.assignedUserId ? "" : "overdue") +
    "</div>" +
    "</div>" +
    '<form class="dispatch-form" data-dispatch-form data-id="' +
    escapeHtml(workOrder.id) +
    '">' +
    '<select name="assignedUserId">' +
    technicians +
    "</select>" +
    '<select name="status">' +
    statusOptions(workOrder.status) +
    "</select>" +
    '<select name="priority">' +
    priorityOptions(workOrder.priority) +
    "</select>" +
    "<button type=\"submit\">Speichern</button>" +
    "</form>" +
    "</article>"
  );
}

function statusOptions(current) {
  return ["scheduled", "in_progress", "paused", "completed", "cancelled"]
    .map((value) => '<option value="' + value + '"' + (value === current ? " selected" : "") + ">" + labels[value] + "</option>")
    .join("");
}

function priorityOptions(current) {
  return ["low", "normal", "high", "urgent"]
    .map((value) => '<option value="' + value + '"' + (value === current ? " selected" : "") + ">" + labels[value] + "</option>")
    .join("");
}

async function updateWorkOrder(event) {
  event.preventDefault();
  const form = event.currentTarget;
  const button = form.querySelector("button");
  button.disabled = true;
  const formData = new FormData(form);
  const response = await fetch("/disposition/api/work-orders/" + encodeURIComponent(form.dataset.id), {
    method: "PATCH",
    headers: {
      authorization: "Bearer " + state.token,
      "content-type": "application/json",
    },
    body: JSON.stringify({
      assignedUserId: formData.get("assignedUserId") || null,
      status: formData.get("status"),
      priority: formData.get("priority"),
    }),
  });
  button.disabled = false;

  if (!response.ok) {
    alert("Auftrag konnte nicht gespeichert werden.");
    return;
  }

  await loadSnapshot();
}

function badge(text, tone) {
  return '<span class="badge ' + tone + '">' + escapeHtml(text) + "</span>";
}

function formatDate(value) {
  if (!value) return "Ohne Termin";
  return new Date(value).toLocaleString("de-CH", {
    day: "2-digit",
    month: "2-digit",
    hour: "2-digit",
    minute: "2-digit",
  });
}

function setLoginMessage(message) {
  qs("#loginMessage").textContent = message;
}

function escapeHtml(value) {
  return String(value ?? "")
    .replaceAll("&", "&amp;")
    .replaceAll("<", "&lt;")
    .replaceAll(">", "&gt;")
    .replaceAll('"', "&quot;")
    .replaceAll("'", "&#039;");
}`;
