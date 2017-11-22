<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/updates/react-v16.0" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page react-v16.0-page">
    <h1>React v16.0</h1>

    <wg:p><b>26 Сентября, 2017. Andrew Clark(Андрей Кларк)</b></wg:p>

    <wg:p>Мы рады объявить о выпуске React v16.0! Среди изменений есть некоторые давние запросы
        возможностей, в том числе фрагменты, границы ошибок, порталы, поддержка пользовательских
        атрибутов DOM, улучшенная отрисовка на стороне сервера и уменьшенный размер файла.</wg:p>

    <h2>Новые типы возврата метода отрисовки: фрагменты и строки</h2>

    <wg:p>Теперь вы можете вернуть массив элементов из метода отрисовки компонента. Как и в
        случае с другими массивами, вам нужно добавить ключ к каждому элементу, чтобы избежать
        предупреждений о ключах:</wg:p>

    <ce:code-example-1/>

    <wg:p>В будущем мы, скорее всего, добавим специальный синтаксис фрагментов
        в JSX, который не требует ключей.</wg:p>

    <wg:p>Мы также добавили поддержку возврата строк:</wg:p>

    <ce:code-example-2/>

    <%--TODO to assign the link--%>
    <wg:p><wg:link href="#">См. Полный список поддерживаемых типов возвращаемых данных.</wg:link></wg:p>

    <h2>Улучшенная обработка ошибок</h2>

    <wg:p>Ранее ошибки во время отрисовки могли приводить React в поврежденное состояние,
        создавая загадочные сообщения об ошибках и требуя обновления страницы для
        восстановления. Для решения этой проблемы в React 16 используется более устойчивая
        стратегия обработки ошибок. По умолчанию, если ошибка возникает внутри методов
        отрисовки компонента или жизненного цикла, все дерево компонентов размонтируется
        из корня. Это предотвращает отображение поврежденных данных. Однако, вероятно,
        это не идеально для удобства работы пользователя.</wg:p>

    <wg:p>Вместо того, чтобы размонтировать все приложение каждый раз, когда есть ошибка,
        вы можете использовать границы ошибок. Границы ошибок - это специальные компоненты,
        которые отлавливают ошибки внутри своего поддерева и отображают резервный интерфейс
        на своем месте. Подумайте о границах ошибок, по аналогии с блоками <code>try-catch</code>,
        но для компонентов React.</wg:p>

    <wg:p>Для получения дополнительной информации ознакомьтесь с нашим предыдущим постом об
        обработке ошибок в React 16.</wg:p>

    <h2>Порталы</h2>

    <wg:p>Порталы предоставляют первоклассный способ отображения дочерних элементов в узел DOM,
        который существует вне иерархии DOM родительского компонента.</wg:p>

    <ce:code-example-3/>

    <!--TODO to assign the link-->
    <wg:p><wg:link href="#">См. Полный пример в документации для порталов.</wg:link></wg:p>

    <h2>Улучшенная отрисовка на стороне сервера</h2>

    <wg:p>React 16 включает полностью переписанную серверную отрисовку. Она очень быстрая.
        Она поддерживает потоки, поэтому вы можете быстрее отправлять байты клиенту. И благодаря
        новой стратегии упаковки, которая компилирует <code>process.env</code> проверки (верьте или нет,
        чтение <code>process.env</code> в Node очень медленное!), Вам больше не нужно связывать React,
        чтобы получить хорошую производительность серверной отрисовки.</wg:p>

    <wg:p>Главный член команды, Саша Айкин, написал замечательную статью, в которой описываются
        улучшения SSR в React 16. Согласно синтетическим бенчмаркам Саши, серверная отрисовка в
        React 16 примерно в три раза быстрее, чем в React 15. «Если сравнивать React 15 со
        скомпилированным <code>process.env</code>, то в Node 4 наблюдается улучшение в 2.4 раза, в
        Node 6 – в 3 раза, и в целых 3,8 раз в новом релизе Node 8.4. И если вы сравните
        React 15 без компиляции, React 16 имеет прирост в SSR на целый порядок величины
        в последней версии Node! »(Саша обращает внимание на то, что эти цифры основаны
        на синтетических бенчмарках и могут не отражать реальную производительность.)</wg:p>

    <wg:p>Кроме того, React 16 лучше увлажняет серверный HTML-код, когда тот достигает клиента.
        Больше не требуется, чтобы начальная отрисовка точно соответствовала результату с сервера.
        Вместо этого он попытается повторно использовать как можно большую часть существующего DOM.
        Больше никаких контрольных сумм! В целом, мы не рекомендуем вам отображать на клиенте контент,
        отличный от серверного, но это может быть полезно в некоторых случаях (например, временные метки).
        Однако опасно иметь недостоющие узлы в серверном рендеринге, поскольку они могут быть пересозданы
        с неправильными атрибутами.</wg:p>

    <!--TODO to assign the link-->
    <wg:p><wg:link>Подробнее см. Документацию для ReactDOMServer.</wg:link></wg:p>

    <h2>Поддержка пользовательских атрибутов DOM</h2>

    <wg:p>Вместо того, чтобы игнорировать нераспознанные HTML и SVG атрибуты, React теперь
        передаст их в DOM. Это дает дополнительное преимущество, позволяя нам избавиться от
        большей части белого списка атрибутов React, что приводит к уменьшению размеров файлов.</wg:p>

    <h2>Уменьшенный размер файла</h2>

    <wg:p>Несмотря на все эти дополнения, React 16 на самом деле меньше по сравнению с 15.6.1!</wg:p>

    <wg:p>
        <ul>
            <li><code>react</code> имеет размер 5.3 kb (2.2 kb - архив gzip), в сравнении с 20.7 kb (6.9 kb - архив gzip).</li>
            <li><code>react-dom</code> имеет размер 103.7 kb (32.6 kb - архив gzip), в сравнении с 141 kb (42.9 kb - архив gzip).</li>
            <li><code>react + react-dom</code> имеет размер 109 kb (34.8 kb - архив gzip), в сравнении с 161.7 kb (49.8 kb - архив gzip).</li>
        </ul>
    </wg:p>

    <wg:p>Все это в сумме имеет итоговое уменьшение <b>32%</b> по сравнению с предыдущей версией.</wg:p>

    <wg:p>Разница в размерах частично объясняется изменением процесса упаковки. Теперь React использует
        Rollup для создания плоских связок для каждого из своих различных целевых форматов, что приводит
        к выигрышу в размере и производительности. Формат плоской связки также означает, что влияние
        React на размер связки приблизительно согласовано, независимо от того, как вы собираете свое
        приложение, будь то с помощью Webpack, Browserify, предварительно построенных связок UMD или
        любой другой системы.</wg:p>

    <h2>MIT  Лицензия</h2>

    <wg:p>В случае, если вы пропустили этот пост, React 16 доступен под лицензией MIT. Мы также опубликовали
        React 15.6.2 под MIT, для тех, кто не может обновиться сразу.</wg:p>

    <h2>Новая архитектура ядра</h2>

    <!--TODO to assign the link-->
    <wg:p>React 16 - первая версия React, построенная построенная на новой архитектуре ядра под кодовым
        названием «<b>Fiber</b>». Вы можете прочитать все об этом проекте в блоге технической поддержки
        Facebook. (Спойлер: <wg:link>мы переписали React!</wg:link>)</wg:p>

    <wg:p><b>Fiber</b> отвечает за большинство новых функций в React 16, таких как границы ошибок и фрагменты.
        В течение следующих нескольких релизов вы можете ожидать больше новых возможностей, так
        как мы начнем полностью раскрывать потенциал React.</wg:p>

    <wg:p>Возможно, самой интересной областью, над которой мы работаем, является асинхронная отрисовка -
        стратегия совместного планирования работы отрисовки, периодически уступающая выполнение браузеру.
        Результатом является то, что при асинхронной отрисовке приложения более отзывчивы, так как
        React избегает блокировки основного потока.</wg:p>

    <wg:p>Эта демонстрация дает общее представление о типах проблем, которые может решить асинхронный рендеринг:</wg:p>

    <wg:p>Мы считаем, что асинхронный рендеринг - это важная задача и представляет будущее React.
        Чтобы сделать миграцию на v16.0 максимально гладкой, мы пока не можем позволить использовать
        какие-либо асинхронные возможности, но мы рады начать разворачивать их в ближайшие месяцы. Будьте на связи!</wg:p>

    <h2>Установка</h2>

    <wg:p><b>React v16.0.0</b> доступен в реестре npm.</wg:p>

    <wg:p>Чтобы установить React 16 с помощью Yarn, выполните:</wg:p>

    <ce:code-example-4/>

    <wg:p>Чтобы установить React 16 с помощью npm, выполните:</wg:p>

    <ce:code-example-5/>

    <wg:p>Мы также предоставляем сборки UMD React через CDN:</wg:p>

    <ce:code-example-6/>

    <!--TODO to assign the link-->
    <wg:p>Подробные инструкции по установке <wg:link>см. В документации.</wg:link></wg:p>

    <h2>Апгрэйд</h2>

    <wg:p>Несмотря на то, что React 16 включает значительные внутренние изменения, с
        точки зрения модернизации вы можете представлять себе это, как и любой другой крупный релиз React.
        Мы обслуживаем React 16 для пользователей Facebook и Messenger.com с начала этого года, и мы
        выпустили несколько бета и релиз версий-кондидатов, чтобы избавиться от дополнительных проблем.
        За небольшими исключениями, если ваше приложение работает с версией 15.6 без каких-либо
        предупреждений, оно должно работать и в версии 16.</wg:p>

    <wg:p>Новый список устаревших элементов</wg:p>

    <wg:p>Гидрация контейнера, отрисованного сервером, теперь имеет явный API. Если вы восстанавливаете
        отрисованный сервером HTML, используйте <code>ReactDOM.hydrate</code> вместо <code>ReactDOM.render</code>.
        Продолжайте использовать <code>ReactDOM.render</code>, если вы просто выполняете отрисовку на стороне клиента.</wg:p>

    <h2>Дополнения React</h2>

    <wg:p>Как было объявлено ранее, мы прекратили поддержку React Addons. Мы ожидаем, что
        последняя версия каждого дополнения (за исключением <code>action-addons-perf</code>, см. Ниже)
        будет работать в обозримом будущем, но мы больше не будем публиковать дополнительные обновления.</wg:p>

    <wg:p>Обратитесь к предыдущему объявлению о предложениях по миграции.</wg:p>

    <wg:p><code>response-addons-perf</code> больше не работает вообще в React 16. Вероятно, в будущем мы выпустим
        новую версию этого инструмента. Тем временем вы можете использовать инструменты производительности
        вашего браузера для профилирования компонентов React.</wg:p>

    <h2>Повреждающие изменения</h2>

    <wg:p>React 16 включает в себя ряд небольших ломающих изменений. Они влияют только на случаи нетипового
        использования, и мы не ожидаем, что они поломают большинство приложений.</wg:p>

    <wg:p>
        <ul>
            <li>Реакт 15 имел ограниченную недокументированную поддержку границ ошибок,
                используя <code>unstable_handleError</code>. Этот метод был переименован в <code>componentDidCatch</code>.
                Вы можете использовать модификацию кода для автоматической миграции на новый API.</li>
            <li><code>ReactDOM.render</code> и <code>ReactDOM.unstable_renderSubtreeIntoContainer</code>
                теперь возвращают <code>null</code>, если вызваны изнутри метода жизненного
                цикла. Чтобы обойти это, вы можете использовать порталы или ссылки <code>refs</code>.</li>
            <li><code>setState</code>:
                <ul>
                    <li>Вызов <code>setState</code> со значением <code>null</code> больше не вызывает обновление. Это
                        позволяет вам принять решение в функции обновления, нужно ли вам
                        провести переотрисовку компонента.</li>
                    <li>Вызов <code>setState</code> непосредственно в методе <code>render</code> всегда вызывает обновление.
                        Раньше это было не так. Независимо от этого, вы не должны вызывать
                        <code>setState</code> из метода рендеринга.</li>
                    <li><code>setState</code> коллбэки (второй аргумент) теперь запускаются сразу после
                        <code>componentDidMount</code> / <code>componentDidUpdate</code>, а не после того,
                        как все компоненты были отрисованы.</li>
                </ul>
            </li>
            <li>При замене &lt;A/&gt; на &lt;B/&gt;, <code>B.componentWillMount</code> теперь всегда вызывается
                до <code>A.componentWillUnmount</code>. Раньше <code>A.componentWillUnmount</code> мог
                сработать первым  в некоторых случаях.</li>
            <li>Раньше изменение ссылки на компонент всегда уничтожало ссылку до
                вызова метода отрисовки компонента. Теперь мы изменяем ссылку <code>ref</code>
                позже, когда применяются изменения к DOM.</li>
            <!--TODO to assign the link-->
            <li>Небезопасно повторно переротисовывать в контейнер, который был изменен чем-то
                иным, чем React. Ранее в некоторых случаях это работало, но никогда не
                поддерживалось. Сейчас в такой ситуации мы выдаем предупреждение. Чтобы
                этого избежать вы должны очистить деревья компонентов,
                используя <code>ReactDOM.unmountComponentAtNode</code>. <wg:link>См. этот пример</wg:link>.</li>
            <!--TODO to assign the link-->
            <li>Метод жизненного цикла <code>componentDidUpdate</code> больше не получает
                параметр <code>prevContext</code>. (См. <wg:link>#8631</wg:link>)</li>
            <li>Поверхностная отрисовка больше не вызывает <code>componentDidUpdate</code>, потому
                что ссылки DOM недоступны. Это делает её совместимой с <code>componentDidMount</code>
                (который не вызывается в предыдущих версиях).</li>
            <li>Поверхностная отрисовка больше не реализует <code>unstable_batchedUpdates</code>.</li>
            <li><code>ReactDOM.unstable_batchedUpdates</code> теперь получает только один дополнительный
                аргумент после метода обратного вызова.</li>
        </ul>
    </wg:p>

    <h2>Упаковка</h2>

    <wg:p>
        <ul>
            <li>Больше нет <code>react/lib/*</code>  и <code>react-dom/lib/*</code> Даже в средах CommonJS, React и ReactDOM
                предварительно скомпилированы в отдельные файлы («плоские связки»). Если
                вы ранее полагались на недокументированные внутренние возможности React, и они больше
                не работают, сообщите нам о вашем конкретном случае в новой проблеме, и мы
                попытаемся найти для вас стратегию миграции.</li>
            <li>Больше нет <code>react-with-addons.js</code>. Все совместимые аддоны публикуются отдельно в npm и имеют
                однофайловые браузерные версии, если они вам нужны.</li>
            <li>Устаревшие элементы, введенные в 15.x, были удалены из пакета ядра. <code>React.createClass</code>
                теперь доступен как <code>create-react-class</code>, <code>React.PropTypes</code> как <code>prop-types</code>, <code>React.DOM</code>
                как <code>react-dom-factories</code>, <code>react-addons-test-utils</code> как <code>react-dom/test-utils</code> и
                поверхностная отрисовка как <code>react-test-renderer/shallow</code>. Смотрите сообщения
                в блогах 15.5.0 и 15.6.0 для инструкций по переносу кода и автоматизарованных кодовых модулей.</li>
            <li>Имена и пути к однофайловым браузерным сборкам изменились, чтобы подчеркнуть
                разницу между сборками <code>development</code>  и <code>production</code>. Например:
                <ul>
                    <li>react/dist/react.js => react/umd/react.development.js</li>
                    <li>react/dist/react.min.js => react/umd/react.production.min.js</li>
                    <li>react-dom/dist/react-dom.js => react-dom/umd/react-dom.development.js</li>
                    <li>react-dom/dist/react-dom.min.js => react-dom/umd/react-dom.production.min.js</li>
                </ul>
            </li>
        </ul>
    </wg:p>

    <h2>Требования к JavaScript среде</h2>

    <wg:p>React 16 зависит от типов коллекций <code>Map</code> и <code>Set</code>. Если вы поддерживаете старые
        браузеры и устройства, которые не могут предоставить их нативно (например, IE < 11),
        подумайте о включении глобального полифилла в ваше приложение,
        например <code>core-js</code> или <code>babel-polyfill</code>.</wg:p>

    <wg:p>Среда с полифилом для React 16, использующая <code>core-js</code> для
        поддержки старых браузеров может выглядеть так:</wg:p>

    <ce:code-example-7/>

    <wg:p>React также зависит от <code>requestAnimationFrame</code> (даже в тестовых средах).
        Простое решение для тестовых сред будет иметь вид:</wg:p>

    <ce:code-example-8/>

    <h2>Благодарности</h2>

    <wg:p>Как всегда, этот релиз был бы невозможен без наших open source контрибуторов.
        Спасибо всем, кто пофиксил баги, открыл PR-ы, ответил на вопросы, написал документацию и многое другое!</wg:p>

    <wg:p>Особая благодарность нашим основным контрибуторам, сделавшим героические усилия за
        последние несколько недель в течение цикла предрелиза: Брэндону Дайлу, Джейсону Куэнсу,
        Натану Хунзакеру и Саше Айкину.</wg:p>
</lt:layout>

<c:url var="nextPageUrl" value="dom-attributes-in-react-16"/>
<app:page-navigate pageStartAncor="pageStart"
                   nextPageUrl="${nextPageUrl}"/>