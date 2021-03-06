<%@ tag pageEncoding="UTF-8" %>
<%@ include file="../../../../baseAttr.tag" %>
<%@taglib prefix="cd" tagdir="/WEB-INF/tags/application/code" %>

<%@ attribute name="cssClass" required="false" rtexprvalue="true" %>
<%@ attribute name="name" required="false" rtexprvalue="true" %>
<%@ attribute name="id" required="false" rtexprvalue="true" %>
<%@ attribute name="codePenUrl" required="false" rtexprvalue="true"%>

<cd:code-example-decorator codePenUrl="${codePenUrl}">
  <pre class="prettyprint">
    <code class="language-javascript">
  class Example extends React.Component {
    constructor(props) {
      super(props);
      this.state = {
        count: 0
      };
    }
    
    <cd:hl>componentDidMount() {</cd:hl>
      <cd:hl>document.title = `Вы нажали \${this.state.count} раз`;</cd:hl>
    <cd:hl>}</cd:hl>
  
    <cd:hl>componentDidUpdate() {</cd:hl>
      <cd:hl>document.title = `Вы нажали \${this.state.count} раз`;</cd:hl>
    <cd:hl>}</cd:hl>
  
    render() {
      return (
        &lt;div>
          &lt;p>Вы нажали {this.state.count} раз&lt;/p>
          &lt;button onClick={() => this.setState({ count: this.state.count + 1 })}>
            Кликни меня
          &lt;/button>
        &lt;/div>
      );
    }
  }</code>
  </pre>
</cd:code-example-decorator>