<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true"%>

<cd:code-example-decorator codePenUrl="${codePenUrl}">
  <pre class="prettyprint">
    <code class="language-javascript">
    // После
    class ExampleComponent extends React.Component {
<cd:hl>      componentDidUpdate(prevProps, prevState) {
        if (this.props.isVisible !== prevProps.isVisible) {
          logVisibleChange(this.props.isVisible);
        }
      }</cd:hl>
    }</code>
  </pre>
</cd:code-example-decorator>