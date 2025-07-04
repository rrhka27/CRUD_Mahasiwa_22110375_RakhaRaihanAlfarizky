<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head><title>Data Mahasiswa</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"  rel="stylesheet">
    </head>
    <body>
        <div class="container mt-5">
            <% if ((Boolean) request.getAttribute("ditemukan")) { %>
                <div class="alert alert-info">Detail Mahasiswa</div>
                <p>NIM: <%= ((model.Mahasiswa) request.getAttribute("mhs")).getNim() %></p>
                <p>Nama: <%= ((model.Mahasiswa) request.getAttribute("mhs")).getNama() %></p>
                <p>Nilai: <%= ((model.Mahasiswa) request.getAttribute("mhs")).getNilai() %></p>
            <% } else { %>
                <div class="alert alert-danger">Data tidak ditemukan.</div>
            <% } %>
            <a href="index.jsp" class="btn btn-secondary">Kembali</a>
        </div>
    </body>
</html>