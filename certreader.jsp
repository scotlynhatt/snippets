<%@ page import="java.security.cert.X509Certificate" %>
<%@ page import="java.security.Principal" %>
<%@ page import="javax.security.auth.x500.X500Principal" %>
<%
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
X500Principal xPrincipal = principalCert.getSubjectX500Principal();

// Extract the common name (CN)
String certFields[] = xPrincipal.toString().split(",");
String certString = "";

// Build a nice table for the data
for(final String field : certFields) {
  String keyVal[] = field.split("=");
  if(keyVal != null && keyVal.length > 0) {
    certString += "<tr><td>" + keyVal[0] +"</td><td>" + keyVal[1] + "</td></tr>";
  }
}
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Client Cert Reader</title>
  <style>
    h1 {
      font-family:Arial, Helvetica, sans-serif;
      color: #000066;
    }
    body {
      font-family:Arial, Helvetica, sans-serif;
      color: #000066;
    }
    td {
      padding: 5px;
    }
  </style>
</head>

<body>
  <div>
    <table border="1">
      <% if(certString != null && certString != "") { %>
      <%= "<h1>** Cert Discovered **</h1>" %>
      <%= certString %>
      <% } %>
    </table>
  </div>
</body>

</html>
