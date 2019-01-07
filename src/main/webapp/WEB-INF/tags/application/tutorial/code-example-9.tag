<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true"%>

<cd:code-example-decorator>
<pre class="prettyprint">
    <code class="language-javascript">
    class Square extends React.Component {
     render() {
       return (
         <cd:hl>&lt;button className="square" onClick={() => alert('click')}></cd:hl>
           {this.props.value}
         &lt;/button>
       );
     }
    }
    </code>
</pre>
</cd:code-example-decorator>