<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>OpsLedger</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/opsledger.css">
</head>
<body>
<main class="ops-main">
    <div class="ops-topbar">
        <div>
            <h1>OpsLedger</h1>
            <p class="ops-muted">Internal operations ledger dashboard for account activity, approvals, and service health.</p>
        </div>
        <div class="ops-actions">
            <a class="ops-button" href="${contextPath}/login">Login</a>
            <a class="ops-button primary" href="${contextPath}/registration">Create Account</a>
        </div>
    </div>

    <section class="ops-grid">
        <div class="ops-card">
            <h3>Account Records</h3>
            <div class="ops-metric">MySQL</div>
            <p class="ops-muted">Stores users and ledger account profiles.</p>
        </div>
        <div class="ops-card">
            <h3>Fast Lookup</h3>
            <div class="ops-metric">Cache</div>
            <p class="ops-muted">Memcached backs repeated account reads.</p>
        </div>
        <div class="ops-card">
            <h3>Async Flow</h3>
            <div class="ops-metric">Queue</div>
            <p class="ops-muted">RabbitMQ models approval events.</p>
        </div>
        <div class="ops-card">
            <h3>Platform</h3>
            <div class="ops-metric">EKS</div>
            <p class="ops-muted">Deployed with Docker, ECR, Helm, and Terraform.</p>
        </div>
    </section>

    <section class="ops-layout">
        <div class="ops-card">
            <h2>Portfolio Architecture</h2>
            <p>OpsLedger demonstrates an application deployment workflow from source code to AWS EKS. The project includes CI checks, container image publishing, Helm deployment, and Terraform-managed infrastructure.</p>
            <div class="ops-actions">
                <a class="ops-button primary" href="${contextPath}/login">Open Dashboard</a>
            </div>
        </div>
        <div class="ops-card">
            <h2>Runtime Services</h2>
            <table class="ops-table">
                <tbody>
                <tr><td>Application</td><td>Java Webapp</td></tr>
                <tr><td>Database</td><td>MySQL</td></tr>
                <tr><td>Cache</td><td>Memcached</td></tr>
                <tr><td>Queue</td><td>RabbitMQ</td></tr>
                </tbody>
            </table>
        </div>
    </section>
</main>
</body>
</html>
