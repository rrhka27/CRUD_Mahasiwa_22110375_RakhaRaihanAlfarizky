<%@ page import="model.Mahasiswa" %>
<jsp:useBean id="mhs" class="model.Mahasiswa" scope="request" />
<jsp:setProperty name="mhs" property="*" />

<%
    boolean berhasil = mhs.simpan();

    // Kirim data dan status ke halaman view
    request.setAttribute("berhasil", berhasil);
    request.setAttribute("mhs", mhs);

    // Arahkan ke view hasil
    request.getRequestDispatcher("mahasiswa.tambah.view.jsp").forward(request, response);
%>
