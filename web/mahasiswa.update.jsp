<%@page import="model.Mahasiswa"%>
<jsp:useBean id="mhs" class="model.Mahasiswa" scope="request"/>
<jsp:setProperty name="mhs" property="*"/>

<%
    boolean berhasil = mhs.update();
    request.setAttribute("berhasil", berhasil);
    request.setAttribute("mhs", mhs);
    request.getRequestDispatcher("mahasiswa.update.view.jsp").forward(request, response);
%>