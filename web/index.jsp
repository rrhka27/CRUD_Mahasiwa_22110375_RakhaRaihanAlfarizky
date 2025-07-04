<%@page import="model.Mahasiswa" %>
<%@page import="java.util.List" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD Mahasiswa</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome CSS -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff; /* Solid white background */
            min-height: 100vh;
            padding: 20px;
            animation: fadeIn 1s ease-in;
        }

        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            background: rgba(255, 255, 255, 0.15);
            border-radius: 20px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            overflow: hidden;
            animation: fadeIn 1.2s ease-in;
        }

        .header-section {
            padding: 2rem;
            text-align: center;
            position: relative;
            color: white;
            overflow: hidden;
            margin: -15px -15px 2rem -15px;
        }

        .header-section::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: radial-gradient(circle, rgba(2, 136, 209, 0.2) 0%, transparent 70%);
            animation: float 8s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            50% { transform: translate(10%, 10%) rotate(180deg); }
        }

        .header-section h2 {
            color : #343a40;
            font-size: 2.8rem;
            font-weight: 700;
            margin: 0;
            position: relative;
            z-index: 1;
            text-shadow: 0 0 10px rgba(2, 136, 209, 0.5);
            animation: glowingText 2s ease-in-out infinite;
        }

        @keyframes glowingText {
            0%, 100% { text-shadow: 0 0 10px rgba(2, 136, 209, 0.5); }
            50% { text-shadow: 0 0 20px rgba(2, 136, 209, 0.8); }
        }

        .header-section i {
            color : #343a40;
            font-size: 2.5rem;
            margin-bottom: 0.5rem;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        .section-header {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.18);
            backdrop-filter: blur(10px);
            animation: fadeIn 1.3s ease-in;
        }

        .search-card {
            background: rgba(255, 255, 255, 0.1);
            border-radius: 15px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            margin-bottom: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.18);
            backdrop-filter: blur(10px);
            animation: fadeIn 1.4s ease-in;
        }

        .search-card .card-body {
            padding: 1.5rem;
        }

        .search-box {
            position: relative;
            flex: 1;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem 0.75rem 2.5rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            background: rgba(255, 255, 255, 0.2);
            color: #0288d1;
            transition: all 0.3s ease;
            backdrop-filter: blur(10px);
            box-shadow: inset 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .form-control::placeholder {
            color : #343a40;
        }

        .form-control:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 3px rgba(2, 136, 209, 0.2);
        }

        .search-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color : #343a40;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            position: relative;
            overflow: hidden;
        }

        .btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255, 255, 255, 0.3), transparent);
            transition: left 0.5s ease;
        }

        .btn:hover::before {
            left: 100%;
        }

        .btn-success {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4);
        }

        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        .btn-outline-primary {
            border: 2px solid #0288d1;
            color: #0288d1;
            background: transparent;
        }

        .btn-outline-primary:hover {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            border-color: #0288d1;
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        .btn-outline-secondary {
            border: 2px solid #0288d1;
            color: #0288d1;
            background: transparent;
        }

        .btn-outline-secondary:hover {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            border-color: #0288d1;
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        .btn-warning {
            background: linear-gradient(135deg, #4fc3f7, #0288d1);
            color: white;
            box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4);
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        .btn-danger {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4);
        }

        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        @keyframes glowing {
            0%, 100% { box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4); }
            50% { box-shadow: 0 8px 25px rgba(2, 136, 209, 0.8); }
        }

        .table-container {
            border-radius: 15px;
            overflow: hidden;
            background: rgba(255, 255, 255, 0.1);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.18);
            animation: fadeIn 1.7s ease-in;
        }

        .table {
            margin: 0;
            background: transparent;
        }

        .table thead th {
            background: rgba(2, 136, 209, 0.2);
            color: #343a40;
            padding: 1rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border: none;
        }

        .table tbody tr {
            transition: all 0.3s ease;
            border: none;
        }

        .table tbody tr:hover {
            background: rgba(224, 247, 250, 0.2);
            transform: scale(1.01);
            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);
        }

        .table tbody td {
            padding: 1rem;
            color: rgba(2, 136, 209, 0.9);
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
            vertical-align: middle;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
            border-radius: 8px;
        }

        .btn-aksi {
            margin-right: 0.5rem;
            min-width: 80px;
        }

        .alert {
            border-radius: 15px;
            padding: 1.5rem;
            font-weight: 500;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
            background: rgba(255, 255, 255, 0.1);
            color: #0288d1;
            border: 1px solid rgba(2, 136, 209, 0.2);
            backdrop-filter: blur(10px);
            animation: fadeIn 1.8s ease-in;
        }

        .nim-badge {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .nilai-badge {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            min-width: 60px;
            display: inline-block;
        }

        .student-name {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
            min-width: 60px;
            display: inline-block;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .main-container {
                margin: 1rem;
                border-radius: 15px;
            }

            .header-section {
                padding: 1.5rem;
            }

            .header-section h2 {
                font-size: 2.2rem;
            }

            .btn-aksi {
                margin-bottom: 0.5rem;
                min-width: auto;
            }

            .d-flex.justify-content-between {
                flex-direction: column;
                gap: 1rem;
            }

            .table {
                font-size: 0.9rem;
            }
        }

        @media (max-width: 480px) {
            .header-section {
                padding: 1rem;
            }

            .header-section h2 {
                font-size: 1.8rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .table {
                font-size: 0.8rem;
            }
        }

        /* FadeIn Animation */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
<div class="container py-3">
    <div class="main-container fade-in">
        <div class="header-section">
            <i class="fas fa-graduation-cap"></i>
            <h2>CRUD Mahasiswa</h2>
        </div>
        
        <div class="px-4 pb-4">
            <div class="section-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h5 class="mb-0 text-dark">
                        <i class="fas fa-list me-2"></i> Daftar Mahasiswa
                    </h5>
                    <a href="mahasiswa.tambah.jsp" class="btn btn-success">
                        <i class="fas fa-plus-circle me-1"></i> Tambah Mahasiswa
                    </a>
                </div>
            </div>

            <!-- Form Pencarian -->
            <div class="card search-card">
                <div class="card-body">
                    <form class="d-flex flex-wrap gap-2" method="get" action="index.jsp">
                        <div class="search-box flex-grow-1">
                            <i class="fas fa-search search-icon"></i>
                            <input type="text" name="keyword" class="form-control" 
                                   placeholder="Cari NIM atau Nama Mahasiswa..." 
                                   value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>">
                        </div>
                        <button type="submit" class="btn btn-outline-primary">
                            <i class="fas fa-search me-1"></i> Cari
                        </button>
                        <a href="index.jsp" class="btn btn-outline-secondary">
                            <i class="fas fa-sync-alt me-1"></i> Reset
                        </a>
                    </form>
                </div>
            </div>

            <%
                String keyword = request.getParameter("keyword");
                List<Mahasiswa> daftarMahasiswa;

                if (keyword != null && !keyword.trim().isEmpty()) {
                    daftarMahasiswa = Mahasiswa.cariMahasiswa(keyword.trim());
                } else {
                    daftarMahasiswa = Mahasiswa.getAllMahasiswa();
                }

                if (daftarMahasiswa.isEmpty()) {
            %>

            <div class="alert text-center">
                <i class="fas fa-exclamation-triangle me-2"></i>
                Belum ada data mahasiswa yang terdaftar.
            </div>
            <%
                } else {
            %>
            <div class="table-container">
                <table class="table table-hover align-middle mb-0">
                    <thead>
                        <tr>
                            <th style="width: 15%;" class="text-center">
                                <i class="fas fa-id-card me-1"></i> NIM
                            </th>
                            <th style="width: 35%;" class="text-center">
                                <i class="fas fa-user me-1"></i> Nama
                            </th>
                            <th style="width: 15%;" class="text-center">
                                <i class="fas fa-star me-1"></i> Nilai
                            </th>
                            <th style="width: 35%;" class="text-center">
                                <i class="fas fa-cogs me-1"></i> Aksi
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Mahasiswa m : daftarMahasiswa) {
                        %>
                        <tr>
                            <td class="text-center">
                                <span class="nim-badge"><%= m.getNim() %></span>
                            </td>
                            <td class="text-center">
                                <span class="student-name"><%= m.getNama() %></span>
                            </td>
                            <td class="text-center">
                                <span class="nilai-badge"><%= m.getNilai() %></span>
                            </td>
                            <td class="text-center">
                                <a href="mahasiswa.update.jsp?nim=<%= m.getNim() %>" class="btn btn-warning btn-sm btn-aksi">
                                    <i class="fas fa-edit me-1"></i> Edit
                                </a>
                                <a href="mahasiswa.hapus.jsp?nim=<%= m.getNim() %>" class="btn btn-danger btn-sm btn-aksi"
                                   onclick="return confirm('Yakin ingin menghapus mahasiswa ini?');">
                                    <i class="fas fa-trash-alt me-1"></i> Hapus
                                </a>
                            </td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
            <%
                }
            %>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>