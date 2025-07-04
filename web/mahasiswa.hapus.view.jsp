<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Hasil Hapus</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"  rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <% if ((Boolean) request.getAttribute("berhasil")) { %>
        <div class="alert alert-success">Data dengan NIM <%= request.getAttribute("nim") %> berhasil dihapus.</div>
    <% } else { %>
        <div class="alert alert-danger">Gagal menghapus data.</div>
    <% } %>
    <a href="index.jsp" class="btn btn-primary">kembali </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script> 
</body>
</html>