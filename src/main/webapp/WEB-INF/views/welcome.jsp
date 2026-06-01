<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html lang="en">
<head>
    <title>OpsLedger Dashboard</title>
    <link rel="stylesheet" href="${contextPath}/resources/css/bootstrap.min.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/opsledger.css">
</head>
<body>
<div class="ops-shell">
    <aside class="ops-sidebar">
        <div class="ops-brand">OpsLedger</div>
        <nav class="ops-nav">
            <a class="active" href="${contextPath}/welcome">Dashboard</a>
            <a href="${contextPath}/users">Accounts</a>
            <a href="${contextPath}/user/rabbit">Approval Queue</a>
            <a href="${contextPath}/user/elasticsearch">Search Index</a>
            <a href="${contextPath}/upload">Documents</a>
            <a onclick="document.forms['logoutForm'].submit()" href="#">Sign Out</a>
        </nav>
    </aside>

    <main class="ops-main">
        <div class="ops-topbar">
            <div>
                <h1>Operations Ledger</h1>
                <p class="ops-muted">Signed in as ${pageContext.request.userPrincipal.name}</p>
            </div>
            <div class="ops-actions">
                <a class="ops-button" href="${contextPath}/user/${pageContext.request.userPrincipal.name}">Edit Profile</a>
                <a class="ops-button primary" href="${contextPath}/users">Review Accounts</a>
            </div>
        </div>

        <section class="ops-grid">
            <div class="ops-card">
                <h3>Ledger Balance</h3>
                <div class="ops-metric">$128.4K</div>
                <p class="ops-muted">Current operating ledger</p>
            </div>
            <div class="ops-card">
                <h3>Active Accounts</h3>
                <div class="ops-metric">42</div>
                <p class="ops-muted">Database-backed records</p>
            </div>
            <div class="ops-card">
                <h3>Approval Queue</h3>
                <div class="ops-metric">20</div>
                <p class="ops-muted">RabbitMQ demo messages</p>
            </div>
            <div class="ops-card">
                <h3>Cache Status</h3>
                <div class="ops-metric">Ready</div>
                <p class="ops-muted">Memcached account lookup</p>
            </div>
        </section>

        <section class="ops-layout">
            <div class="ops-card">
                <h2>Recent Ledger Activity</h2>
                <table class="ops-table">
                    <thead>
                    <tr>
                        <th>Reference</th>
                        <th>Account</th>
                        <th>Type</th>
                        <th>Status</th>
                        <th>Amount</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td>OL-1048</td>
                        <td>Platform Operations</td>
                        <td>Cloud service allocation</td>
                        <td><span class="ops-pill">Approved</span></td>
                        <td>$8,420</td>
                    </tr>
                    <tr>
                        <td>OL-1047</td>
                        <td>Customer Success</td>
                        <td>Vendor payment</td>
                        <td><span class="ops-pill">Queued</span></td>
                        <td>$3,100</td>
                    </tr>
                    <tr>
                        <td>OL-1046</td>
                        <td>Security Review</td>
                        <td>Access change</td>
                        <td><span class="ops-pill">Cached</span></td>
                        <td>$0</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="ops-card">
                <h2>Service Health</h2>
                <table class="ops-table">
                    <tbody>
                    <tr>
                        <td>Web</td>
                        <td><span class="ops-pill">EKS</span></td>
                    </tr>
                    <tr>
                        <td>Database</td>
                        <td><span class="ops-pill">MySQL</span></td>
                    </tr>
                    <tr>
                        <td>Cache</td>
                        <td><span class="ops-pill">Memcached</span></td>
                    </tr>
                    <tr>
                        <td>Queue</td>
                        <td><span class="ops-pill">RabbitMQ</span></td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>

<form id="logoutForm" method="POST" action="${contextPath}/logout"></form>
</body>
</html>
