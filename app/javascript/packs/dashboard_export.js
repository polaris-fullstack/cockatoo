document.addEventListener("DOMContentLoaded", () => {
  const exportBtn = document.getElementById("export-csv");
  if (!exportBtn) return;
  exportBtn.addEventListener("click", () => {
    const rows = Array.from(document.querySelectorAll("table tr")).map(row =>
      Array.from(row.querySelectorAll("th,td")).map(cell => cell.innerText)
    );
    let csv = rows.map(r => r.join(",")).join("\n");
    const blob = new Blob([csv], { type: "text/csv" });
    const url = URL.createObjectURL(blob);
    const a = document.createElement("a");
    a.href = url;
    a.download = "finance_applications_export.csv";
    document.body.appendChild(a);
    a.click();
    document.body.removeChild(a);
    URL.revokeObjectURL(url);
  });
});
