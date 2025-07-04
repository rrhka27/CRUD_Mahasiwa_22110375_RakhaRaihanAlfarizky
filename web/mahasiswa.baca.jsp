<%@page import="model.Mahasiswa"%>
<jsp:useBean id="mhs" class="model.Mahasiswa" scope="request"/>
<jsp:setProperty name="mhs" property="nim" param="nim"/>

<%
    boolean ditemukan = mhs.baca(mhs.getNim());
    request.setAttribute("ditemukan", ditemukan);
    request.setAttribute("mhs", mhs);
    request.getRequestDispatcher("mahasiswa.baca.view.jsp").forward(request, response);
%>