<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.security.Principal" %>
<%
// Later in the page...
// Get the client SSL certificates associated with the request
X509Certificate certs[] = (X509Certificate[]) request.getAttribute("jakarta.servlet.request.X509Certificate");

// Check that a certificate was obtained
if (certs == null || certs.length == 0) {
  System.err.println("SSL not client authenticated");
  return;
}
// The base of the certificate chain contains the client's info
X509Certificate principalCert = certs[0];

// Get the Distinguished Name from the certificate
// Ex/ "E=joeuser@endeca.com, CN=joeuser, O=Endeca,
//     "L=Cambridge, S=MA, C=US"
Principal principal = principalCert.getSubjectDN();

// Extract the common name (CN)
int start = principal.getName().indexOf("CN");
String tmpName, name = "";
if (start > 0) { 
  tmpName = principal.getName().substring(start+3);
  int end = tmpName.indexOf(",");
  if (end > 0) {
    name = tmpName.substring(0, end);
  }
  else {
    name = tmpName; 
  }
}
%>
<%= name %>

