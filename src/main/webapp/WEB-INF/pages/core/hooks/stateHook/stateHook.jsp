<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/core/hooks/state-hook" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>
<%@taglib prefix="ad" tagdir="/WEB-INF/tags/application/advertising" %>

<c:url var="corsUrl" value="https://developer.mozilla.org/en-US/docs/Web/HTML/CORS_settings_attributes"/>
<c:url var="httpHeaderUrl" value="/resources/imges/pages/introduction/installation/http_header.png"/>
<c:url var="errorHandlingUrl" value="/updates/error-handling-in-react-16"/>

<a name="pageStart"></a>
<div class="black-line"></div>
<div class="page state-hook-page">
    <h1>3.12.3 Хук состояния</h1>

    <br/>

    <p class="introduction">
        Хуки доступны в версии <b>React 16.8</b>. Они позволяют вам использовать состояние и другие
        функции React без написания класса.
    </p>

    <br/>

    <p>
        В предыдущем разделе хуки были представлены с помощью данного примера:
    </p>

    <ce:code-example-1/>

    <p>
        Мы продолжим изучать хуки, сравнивая данный код с эквивалентным примером класса.
    </p>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.1 Эквивалентный пример класса</h2>
    <br/>

    <p>
        Если ранее вы использовали классы в React, данный код должен выглядеть знакомо:
    </p>

    <ce:code-example-2/>

    <p>
        Состояние начинается с <code>{count: 0}</code>, а затем мы увеличиваем значение <code>state.count</code>,
        когда пользователь нажимает кнопку, вызывая <code>this.setState()</code>. Мы будем использовать
        фрагменты этого класса по всему разделу.
    </p>

    <app:alert title="Внимание!" type="warning">
        Вы можете удивиться, почему здесь мы используем счетчик вместо более
        реалистичного примера. Однако это поможет нам больше сосредоточиться на API,
        пока мы делаем первые шаги с помощью хуков.
    </app:alert>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.2 Хуки и компоненты-функции</h2>
    <br/>

    <p>
        Напоминаем, что компоненты-функции в React выглядят так:
    </p>

    <ce:code-example-3/>

    <p>или так:</p>

    <ce:code-example-4/>

    <p>
        Ранее вы, возможно, знали их как «компоненты без состояния». Сейчас
        эти компоненты получают возможность использовать состояние, поэтому для них мы
        предпочитаем название «компоненты-функции».
    </p>
    
    <ad:ad-content-banner-1/>

    <p>
        <b>Хуки не работают внутри классов</b>, однако теперь вы
        можете их использовать вместо написания самих классов.
    </p>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.3 Что такое хук?</h2>
    <br/>

    <p>Наш новый пример начинается с импорта хука <code>useState</code> из React:</p>

    <ce:code-example-5/>

    <p>
        <b>Что такое хук?</b> Хук - это специальная функция, которая позволяет «прицепиться»
        к возможностям React. Например, <code>useState</code> - это хук, который позволяет добавлять
        состояние React к компонентам-функциям. С другими хуками мы познакомимся позже.
    </p>

    <p>
        <b>Когда можно использовать хук?</b> Если вы пишете компонент-функцию и в
        какой-то понимаете, что вам нужно добавить в него какое-то состояние,
        то ранее вам приходилось преобразовывать его в класс. Теперь вы можете
        использовать хук внутри существующего компонента-функции. Давайте
        сделаем это прямо сейчас!
    </p>

    <%--<c:url var="hookRulesUrl" value="/core/hooks/rules"/>--%>
    <c:url var="hookRulesUrl" value="https://reactjs.org/docs/hooks-rules.html"/>

    <app:alert title="Внимание!" type="warning">
        Есть некоторые специальные правила относительно того, где вы можете и
        не можете использовать хуки в компоненте. Мы узнаем о них в
        разделе <b><a href="${hookRulesUrl}">Правила использования хуков</a></b>.
    </app:alert>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.4 Объявление переменной состояния</h2>
    <br/>

    <p>
        В классе мы инициализируем состояние счетчика значением <code>0</code>,
        устанавливая <code>this.state</code> равным <code>{count: 0}</code> в конструкторе:
    </p>

    <ce:code-example-6/>

    <p>
        В компоненте-функции у нас такой возможности нет, поэтому мы не
        можем назначить или прочитать <code>this.state</code>. Вместо этого
        мы вызываем хук <code>useState</code> прямо внутри нашего компонента:
    </p>

    <ce:code-example-7/>

    <p>
        <b>Что делает вызов <code>useState</code>?</b> Он объявляет «переменную состояния». Это способ
        «сохранять» некоторые значения между вызовами функций. Наша переменная называется <code>count</code>,
        но мы можем назвать ее как угодно, например, <code>banana</code>. <code>useState</code> - это новый способ
        использовать точно такие же возможности, которые <code>this.state</code> предоставляет в классе.
        Обычно переменные теряются при выходе из функции, но переменные состояния сохраняются React-ом.
    </p>

    <p>
        <b>Что мы передаем <code>useState</code> в качестве аргумента?</b> Единственный аргумент для хука <code>useState()</code> -
        это начальное состояние. В отличие от классов, состояние не обязательно должно быть объектом.
        Мы можем сохранять число или строку, если это все, что нам нужно. В нашем примере мы хотим хранить
        просто число, показывающее сколько раз пользователь кликал, поэтому передаем <code>0</code> в качестве начального
        состояния для нашей переменной. (Если бы мы хотели сохранить два разных значения в состоянии,
        мы бы вызвали <code>useState()</code> дважды.)
    </p>

    <p>
        <b>Что возвращает <code>useState</code>?</b> Он возвращает два значения: текущее состояние и функцию, которая
        его обновляет. Вот почему мы пишем <code>const [count, setCount] = useState()</code>. Это похоже на <code>this.state.count</code> и
        <code>this.setState</code> в классе, за исключением того, что вы получаете их в паре. Если вы не знакомы с синтаксисом,
        который мы использовали, мы вернемся к нему <b><a href="#1">внизу этого раздела</a></b>.
    </p>

    <p>
        Теперь, когда мы знаем, что делает хук <code>useState</code>, наш пример должен иметь больше смысла:
    </p>

    <ce:code-example-7/>

    <p>
        Мы объявляем переменную состояния с именем <code>count</code> и устанавливаем ее равной <code>0</code>.
        React запоминает ее текущее значение между повторными отрисовками и предоставляет самое
        последнее значение для нашей функции. Если мы хотим обновить текущее значение счетчика,
        мы можем вызвать <code>setCount</code>.
    </p>
    
    <ad:ad-content-banner-2/>

    <app:alert title="Внимание!" type="warning">
        Вы можете задаться вопросом: почему <code>useState</code> не называется <code>createState</code>?
        <br/>
        <br/>
        Слово «создать» будет не совсем точным, поскольку состояние создается только
        при первой отрисовке нашего компонента. Во время следующих отрисовок <code>useState</code>
        возвращает нам текущее состояние. Иначе это не является "состоянием" вообще! Существует также
        причина, по которой имена хуков всегда начинаются с <code>use</code>.
        Мы узнаем почему в разделе <b><a href="${hookRulesUrl}">Правила использования хуков</a></b>.
    </app:alert>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.5 Чтение состояния</h2>
    <br/>

    <p>
        Когда мы хотим отобразить текущий счетчик в классе, мы
        считываем <code>this.state.count</code>:
    </p>

    <ce:code-example-8/>

    <p>В функции мы можем использовать <code>count</code> напрямую:</p>

    <ce:code-example-9/>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.6 Обновление состояния</h2>
    <br/>

    <p>В классе нам нужно вызвать <code>this.setState()</code>, чтобы
        обновить состояние счетчика:</p>

    <ce:code-example-10/>

    <p>
        В функции у нас теперь есть переменные <code>setCount</code> и <code>count</code>,
        поэтому такой вызов не нужен:
    </p>

    <ce:code-example-11/>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.7 Резюме</h2>
    <br/>

    <p>
        Теперь давайте <b>резюмируем то, что мы узнали</b>, построчно и проверим наше понимание.
    </p>

    <ce:code-example-12/>

    <ul>
        <li>
            <p>
                <b>Строка 1:</b> мы импортируем хук <code>useState</code> из React. Это
                позволяет нам сохранять локальное состояние в компоненте-функции.
            </p>
        </li>
        <li>
            <p>
                <b>Строка 4:</b> внутри компонента <code>Example</code> мы объявляем новую переменную состояния,
                вызывая хук <code>useState</code>. Он возвращает пару значений, которым мы даем имена. Мы называем
                нашу переменную <code>count</code>, потому что она содержит количество нажатий кнопки. Мы инициализируем
                её нулем, передавая <code>0</code> как единственный аргумент <code>useState</code>. Второй возвращаемый элемент сам
                по себе является функцией и позволяет нам обновлять счетчик <code>count</code>, поэтому мы назовем его <code>setCount</code>.
            </p>
        </li>
        <li>
            <p>
                <b>Строка 9:</b> когда пользователь кликает, мы вызываем <code>setCount</code> с новым значением. Затем React
                повторно выполнит отрисовку компонента <code>Example</code>, передав ему новое значение <code>count</code>.
            </p>
        </li>
    </ul>

    <p>
        Поначалу это может показаться слишком сложным. Но не торопитесь! Если вы запутались в нашем объяснении,
        снова посмотрите на приведенный выше код и попробуйте прочитать его сверху вниз. Мы обещаем, что как
        только вы попытаетесь «забыть», как работает состояние в классах, и посмотрите на этот код свежим
        взглядом, его смысл станет полностью понятен.
    </p>

    <br/>
    <h3>3.12.3.7.1 Подсказка: что означают квадратные скобки?</h3>
    <br/>

    <p>
        Вы могли заметить квадратные скобки, когда мы объявляем переменную состояния:
    </p>

    <ce:code-example-13/>

    <p>
        Имена слева не являются частью React API. Вы можете назначить свои
        собственные имена переменным состояния:
    </p>

    <ce:code-example-14/>

    <p>
        Данный синтаксис JavaScript называется <b>«деструктуризация массива»</b>. Он означает, что мы
        создаем две новые переменные <code>fruit</code> и <code>setFruit</code>, где во <code>fruit</code> устанавливается первое значение,
        возвращаемое <code>useState</code>, а в <code>setFruit</code> второе. Это эквивалентно следующему коду:
    </p>

    <ce:code-example-15/>

    <p>
        Когда мы объявляем переменную состояния с помощью <code>useState</code>, он возвращает пару - массив с
        двумя элементами. Первый элемент - это текущее значение, а второй - функция, которая
        позволяет нам его обновлять. Использование <code>[0]</code> и <code>[1]</code> для доступа к ним немного сбивает с толку,
        поскольку они имеют конкретное смысловое значение. Вот почему вместо этого мы используем
        деструктуризацию массива.
    </p>

    <%--<c:url var="faqUrl" value=""/>--%>
    <c:url var="faqUrl" value="https://reactjs.org/docs/hooks-faq.html"/>

    <app:alert title="Внимание!" type="warning">
        Вам может быть любопытно, как React узнает, какому компоненту
        соответствует <code>useState</code>, ведь мы не передаем React никакой
        информации вроде <code>this</code>. Мы ответим на этот и многие другие
        вопросы в разделе <b><a href="${faqUrl}">FAQ по хукам</a></b>.
    </app:alert>

    <br/>
    <h3>3.12.3.7.1 Подсказка: использование множества переменных состояния</h3>
    <br/>

    <p>
        Объявление переменных состояния как пары <code>[нечто, setНечто]</code> также удобно
        потому, что позволяет нам давать им разные имена, если мы хотим использовать несколько переменных:
    </p>

    <ce:code-example-16/>

    <p>
        В приведенном компоненте у нас есть <code>age</code>, <code>fruit</code> и <code>todos</code> в качестве
        локальных переменных, и мы можем обновлять их индивидуально:
    </p>

    <ce:code-example-17/>

    <p>
        Вам <b>не обязательно</b> использовать много переменных состояния. Переменные состояния
        могут отлично хранить объекты и массивы, так что вы можете группировать связанные данные вместе.
        Однако, в отличие от <code>this.setState</code> в классе, <b>обновление переменной состояния всегда
        заменяет ее</b>, а не объединяет(мержит).
    </p>

    <p>
        Мы даем больше рекомендаций по разбиению независимых
        переменных состояния в <b><a href="${faqUrl}">FAQ</a></b>.
    </p>

    <br/>
    <br/>
    <div class="gray-line"></div>
    <h2>3.12.3.8 Следующие шаги</h2>
    <br/>

    <p>
        В этом разделе мы узнали об одном из хуков, предоставляемых React, который
        называется <code>useState</code>. Мы иногда будем называть его <b>«хук состояния»</b>. Он позволяет
        нам добавлять локальное состояние к компонентам-функциям React, что нам удалось сделать впервые!
    </p>

    <p>
        Также мы узнали немного больше о том, что такое хуки. Хуки - это функции, которые
        позволяют вам «зацепить» возможности React из компонентов-функций. Их имена всегда начинаются с <code>use</code>.
        Существуют и еще некоторые хуки, которых мы пока не рассматривали.
    </p>
    
    <c:url var="effectHookUrl" value="https://reactjs.org/docs/hooks-effect.html"/>
    
    <p>
        Теперь давайте перейдем к <b><a href="${effectHookUrl}">изучению следующего хука: useEffect</a></b>. Он позволяет
        выполнять побочные эффекты в компонентах и аналогичен методам жизненного цикла в классах.
    </p>
    <p></p>

    <%-- <c:url var="Url" value=""/> --%>

    <%--
    <ul>
        <li>
            <p>

            </p>
        </li>
    </ul>
    --%>
    <%-- <app:alert title="Внимание!" type="warning"></app:alert> --%>
    <%-- <code></code> --%>
    <%-- <b></b> --%>
    <%-- <code>&lt; &gt;</code> --%>
    <%-- <b><a href="${}"></a></b> --%>
    <%-- <b><a href="#"></a></b> --%>
    <%-- <a href="#"></a> --%>

</div>

<c:url var="prevPageUrl" value="/core/hooks/glance"/>
<c:url var="nextPageUrl" value="/core/hooks/effect-hook"/>

<app:page-navigate
        pageStartAncor="pageStart"
        prevPageUrl="${prevPageUrl}"
        nextPageUrl="${nextPageUrl}"
/>