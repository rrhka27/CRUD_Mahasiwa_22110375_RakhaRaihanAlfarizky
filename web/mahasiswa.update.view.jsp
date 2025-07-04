<%@page import="model.Mahasiswa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    String nim = request.getParameter("nim");
    Mahasiswa m = new Mahasiswa();
    if (m.baca(nim)) {
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Mahasiswa</title>
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

        .container {
            max-width: 800px; /* Smaller container for form */
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

        .card {
            background: transparent;
            border: none;
        }

        .card-header {
            padding: 2rem;
            text-align: center;
            position: relative;
            color: white;
            overflow: hidden;
            border-radius: 20px 20px 0 0;
        }

        .card-header::before {
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

        .card-header h4 {
            color : #343a40;
            font-size: 2rem;
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

        .card-body {
            padding: 2rem;
            animation: fadeIn 1.4s ease-in;
        }

        .form-label {
            color: #0288d1;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.75rem 1rem;
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
            color: rgba(2, 136, 209, 0.7);
        }

        .form-control:focus {
            outline: none;
            background: rgba(255, 255, 255, 0.3);
            box-shadow: 0 0 0 3px rgba(2, 136, 209, 0.2);
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

        .btn-warning {
            background: linear-gradient(135deg, #0288d1, #4fc3f7);
            color: white;
            box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4);
        }

        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        .btn-secondary {
            background: linear-gradient(135deg, #4fc3f7, #0288d1);
            color: white;
            box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4);
        }

        .btn-secondary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(2, 136, 209, 0.6);
            animation: glowing 1s ease-in-out infinite;
        }

        @keyframes glowing {
            0%, 100% { box-shadow: 0 4px 15px rgba(2, 136, 209, 0.4); }
            50% { box-shadow: 0 8px 25px rgba(2, 136, 209, 0.8); }
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
            text-align: center;
        }

        /* Responsive Design */
        @media (max-width: 768px) {
            .container {
                margin: 1rem;
                padding: 1rem;
            }

            .card-header {
                padding: 1.5rem;
            }

            .card-header h4 {
                font-size: 1.8rem;
            }

            .card-body {
                padding: 1.5rem;
            }
        }

        @media (max-width: 480px) {
            .card-header {
                padding: 1rem;
            }

            .card-header h4 {
                font-size: 1.6rem;
            }

            .btn {
                padding: 0.5rem 1rem;
                font-size: 0.9rem;
            }

            .form-control {
                font-size: 0.9rem;
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
<div class="container py-5">
    <div class="card">
        <div class="card-header">
            <h4><i class="fas fa-edit"></i> Edit Mahasiswa</h4>
        </div>
        <div class="card-body">
            <form action="mahasiswa.update.jsp" method="post">
                <input type="hidden" name="aksi" value="edit">
                <input type="hidden" name="nim" value="<%= m.getNim() %>">

                <div class="mb-3">
                    <label for="nama" class="form-label">Nama</label>
                    <input type="text" class="form-control" id="nama" name="nama" value="<%= m.getNama() %>" required>
                </div>

                <div class="mb-3">
                    <label for="nilai" class="form-label">Nilai</label>
                    <input type="number" class="form-control" id="nilai" name="nilai" value="<%= m.getNilai() %>" min="0" max="100" required>
                </div>

                <button type="submit" class="btn btn-warning"><i class="fas fa-save"></i> Update</button>
                <a href="index.jsp" class="btn btn-secondary"><i class="fas fa-arrow-left"></i> Kembali</a>
            </form>
        </div>
    </div>
</div>

<!-- Bootstrap 5 JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<!-- Font Awesome JS -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/js/all.min.js"></script>
</body>
</html>
<%
    } else {
        out.println("<div class='alert'>Data tidak ditemukan.</div>");
    }
%>