<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true" %>

<cd:code-example codePenUrl="${codePenUrl}">
    <pre class="prettyprint">
        <code class="language-javascript">
  const userList = users.map((user, index) =&gt;
    <cd:hl>// Делать так только в том случае, если элементы не имеют стабильных ID</cd:hl>
    &lt;li key={<cd:hl>index</cd:hl>}&gt;
      {user.name}
    &lt;/li&gt;
  );</code>
    </pre>
</cd:code-example>