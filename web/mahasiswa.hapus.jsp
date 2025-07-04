<%@page import="model.Mahasiswa"%>
<jsp:useBean id="mhs" class="model.Mahasiswa" scope="request"/>
<jsp:setProperty name="mhs" property="nim"/>

<%
    boolean berhasil = mhs.hapus();
    request.setAttribute("berhasil", berhasil);
    request.setAttribute("nim", mhs.getNim());
    request.getRequestDispatcher("mahasiswa.hapus.view.jsp").forward(request, response);
%>