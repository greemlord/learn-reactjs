<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/basics/state-and-lifecycle" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<c:url var="granularDomUpdatesUrl" value="/resources/imges/pages/basics/render-elements/granular-dom-updates.gif"/>

<lt:layout cssClass="page hello-world-example-page">
    <h1>2.6 Состояние и жизненный цикл</h1>

    <wg:p>Рассмотрим пример тикающих часов из предыдущего раздела.</wg:p>

    <wg:p>До сих поло мы изучили только один способ обновления UI.</wg:p>

    <wg:p>Мы вызываем <code>ReactDOM.render()</code> чтобы изменить отрисовывамый вывод:</wg:p>

    <ce:code-example-1 codePenUrl="https://codepen.io/stzidane/pen/QgWgNP?editors=0010"/>

    <wg:p>В этом разделе мы изучим, как сделать компонент <code>Timer</code> по-настоящему переиспользумым и
        инкапсулированным. Он будет устанавливать свой таймер и обновлять себя каждый определенный
        промежуток времени.</wg:p>

    <wg:p>Мы можем начать с инкапсуляции кода в компонент <code>Timer</code>:</wg:p>

    <ce:code-example-2 codePenUrl="https://codepen.io/stzidane/pen/yXLXKY?editors=0010"/>

    <wg:p>Тем не менее, он упускает ключевое требование: установка таймера и обновление UI
        каждую секунду должны быть деталью реализации <code>Timer</code>.</wg:p>
    <wg:p>В идеале, нам необходимо написать следующий код с компонентом <code>Timer</code>, обновляющим самого себя:</wg:p>

    <ce:code-example-3/>

    <wg:p>Для того, чтобы это реализовать, нам необходимо добавить «<b>состояние</b>» к компоненту <code>Timer</code>.</wg:p>

    <wg:p>Состояние подобно свойствам <b>props</b>, но является приватным и полностью контролируется компонентом.</wg:p>

    <wg:p>Ранее мы упоминали что, компоненты, определённые как классы, имеют некоторые дополнительный возможности.
        <b>Локальное состояние является возможностью, доступной только для классов.</b></wg:p>

    <br/>
    <h2>2.6.1 Преобразование функций в классы</h2>

    <wg:p>Мы можем преобразовать функциональный компонент <code>Timer</code> в класс в пять шагов:</wg:p>
    <wg:p>
        <ol>
            <li>Создать ES6 класс с тем же самым именем, который расширяет <code>React.Component</code>.</li>
            <li>Добавить в него единственный пустой метод под названием <code>render()</code>.</li>
            <li>Поместить тело функции в метод <code>render()</code>.</li>
            <li>Заменить <code>props</code> на <code>this.props</code> в теле метода <code>render()</code>.</li>
            <li>Удалить оставшееся пустое определение функции</li>
        </ol>
    </wg:p>

    <ce:code-example-4 codePenUrl="https://codepen.io/stzidane/pen/xrxrQP?editors=0010"/>

    <wg:p>Теперь компонент <code>Timer</code> определен как класс, а не функция.</wg:p>

    <wg:p>Это позволяет нам использовать дополнительные возможности, такие как локальное состояние и
        методы жизненного цикла.</wg:p>

    <br/>
    <h2>2.6.2 Добавление локального состояния в класс</h2>

    <wg:p>Мы переместим <code>date</code> из <code>props</code> в состояние в три шага.</wg:p>

    <wg:p>1. Заменим <code>this.props.value</code> на <code>this.state.value</code> в <code>render()</code> методе:</wg:p>

    <ce:code-example-5/>

    <wg:p>2. Добавим конструктор класса, который устанавливает начальное состояние <code>this.state</code>:</wg:p>

    <ce:code-example-6/>

    <wg:p>Обратите внимание на то, как мы передаем свойства <code>props</code> в базовый конструктор:</wg:p>

    <ce:code-example-7/>

    <wg:p><b>Компоненты-классы должны всегда вызывать базовый конструктор с</b> <code>props</code>.</wg:p>

    <wg:p>3. Удаляем свойство <code>value</code> из <code>&lt;Timer /&gt;</code> элемента:</wg:p>

    <ce:code-example-8/>

    <wg:p>Позже мы добавим код таймера обратно в сам компонент.</wg:p>

    <wg:p>Результат будет выглядеть следующим образом:</wg:p>

    <ce:code-example-9 codePenUrl="https://codepen.io/stzidane/pen/GERvKL?editors=0010"/>

    <wg:p>Далее мы сделаем так, что компонент <code>Timer</code> будет устанавливать таймер и обновлять себя каждую секунду.</wg:p>

    <br/>
    <h2>2.6.3 Добавление методов жизненного цикла в класс</h2>

    <wg:p>В приложениях с множеством компонентов очень важно высвобождать ресурсы,
        занятые компонентами, когда они уничтожаются.</wg:p>

    <wg:p>Нам необходимо устанавливать таймер каждый раз, когда <code>Timer</code>
        отрисовывается в DOM в первый раз. В React это называется «<b>монтированием/монтажём</b>».</wg:p>

    <wg:p>Также нам нужно очищать этот таймер, каждый раз когда DOM, созданный
        компонентом <code>Timer</code>, удаляется. В React это называется «<b>демонтированием/демонтажём</b>».</wg:p>

    <wg:p>Мы можем объявить специальные методы в классе компонента, чтобы запускать определенный
        код, когда компонент монтируется или демонтируется:</wg:p>

    <ce:code-example-10/>

    <wg:p>В документации эти методы носят название «<b>lifecycle hooks</b>». Мы же
        будем для простоты называть их методами жизненного цикла.</wg:p>

    <wg:p>Метод <code>componentDidMount()</code> срабатывает после того, как
        компонент был отрисован в DOM. Это хорошее место чтобы установить таймер:</wg:p>

    <ce:code-example-11/>

    <wg:p>Обратите внимание как мы сохраняем ID таймера прямо в <code>this</code>.</wg:p>

    <wg:p>В то время как <code>this.props</code> самостоятельно устанавливаются React-ом и
        <code>this.state</code> имеет определенное значение, вы свободно можете добавить
        дополнительные поля в класс вручную, если вам необходимо хранить что-нибудь,
        что не используется для визуального вывода.</wg:p>

    <wg:p>Если вы не используете что-то в <code>render()</code>, оно не должно
        находиться в состоянии <code>state</code>.</wg:p>

    <wg:p>Мы перенесем таймер в <code>componentWillUnmount()</code> метод жизненного цикла:</wg:p>

    <ce:code-example-12/>

    <wg:p>В итоге, мы реализуем <code>increment()</code> метод, который выполняется каждую секунду.</wg:p>

    <wg:p>Он будет использовать <code>this.setState()</code> чтобы планировать обновления
        в локальном состоянии компонента:</wg:p>

    <ce:code-example-13 codePenUrl="https://codepen.io/stzidane/pen/vZYJLP?editors=0010"/>

    <wg:p>Теперь таймер обновляется каждый установленный промежуток времени.</wg:p>

    <wg:p>Теперь давайте прорезюмируем, что произошло и порядок, в котором вызываются методы:</wg:p>

    <wg:p>
        <ol>
            <li>Когда <code>&lt;Timer/&gt;</code> передан в <code>ReactDOM.render()</code>, React вызывает
                конструктор компонента <code>Timer</code>. Как только <code>Timer</code> нуждается в
                отображении текущего значения, он инициализирует <code>this.state</code> с
                объектом, включающим текущее значение таймера. Позже мы обновим это состояние.</li>

            <li>Далее React вызывает метод <code>render()</code> компонента <code>Timer</code>. Это то,
                как React понимает, что должно быть отображено на экране. Далее React обновляет DOM, в
                соответствии с результатом отрисовки <code>Timer</code>.</li>

            <li>Когда результат отрисовки <code>Timer</code> вставлен в DOM, React вызывает
                метод <code>componentDidMount()</code> жизненного цикла. Внутри него компонент
                <code>Timer</code> обращается к браузеру для установки таймера, чтобы
                вызывать <code>increment()</code> раз в секунду.</li>

            <li>Каждую секунду браузер вызывает <code>increment()</code>  метод. Внутри него <code>Timer</code>
                компонент планирует обновление UI с помощью вызова <code>setState()</code> с объектом,
                содержащим текущее время. Благодаря вызову <code>setState()</code>, React знает, что состояние
                изменилось, и вызывает метод <code>render()</code> снова, чтобы узнать, что должно быть на экране.
                Значение <code>this.state.value</code> в методе <code>render()</code> будет отличаться, поэтому результат отрисовки будет содержать обновленное значение таймера. React обновляет DOM соответственно.</li>

            <li>Если компонент <code>Timer</code> в какой-то момент удалён из DOM, React вызывает
                метод <code>componentWillUnmount()</code> жизненного цикла, из-за чего таймер останавливается.</li>
        </ol>
    </wg:p>

    <br/>
    <h2>2.6.4 Корректное обновление состояния</h2>

    <wg:p>Необходимо знать <b>три вещи</b> о <code>setState()</code>.</wg:p>

    <br/>
    <h3>2.6.4.1 Не модифицируйте состояние напрямую</h3>

    <wg:p>К примеру, это не перерисовываемый компонент:</wg:p>

    <ce:code-example-14/>

    <wg:p>Вместо этого используйте метод <code>setState()</code>:</wg:p>

    <ce:code-example-15/>

    <app:alert title="Внимание!" type="warning">Вы можете назначить <code>this.state</code> только в конструкторе!</app:alert>

    <br/>
    <h3>2.6.4.2 Обновления состояния могут быть асинхронными</h3>

    <wg:p>React может собирать в множественные вызовы <code>setState()</code> в единое обновление
        в целях производительности.</wg:p>

    <wg:p>Так как <code>this.props</code> и <code>this.state</code> могут быть обновлены асинхронно,
        вы не должны полагаться на их значения для вычисления следующего состояния.</wg:p>

    <wg:p>К примеру, данный код может сломаться при обновлении счетчика:</wg:p>

    <ce:code-example-16/>

    <wg:p>Для того, чтобы это исправить, используйте следующую форму метода <code>setState()</code>, который
        принимает функцию, вместо объекта. Это функция будет принимать предыдущее состояние как первый
        аргумент и свойства в момент обновления как следующий аргумент.</wg:p>

    <ce:code-example-17/>

    <wg:p>Мы используем стрелочную функцию выше, но можно использовать и обычные функции:</wg:p>

    <ce:code-example-18/>

    <br/>
    <h3>2.6.4.3 Обновления состояния мерджатся(merge)</h3>

    <wg:p>Когда вы вызываете <code>setState()</code>, React производит мерджит(производит слияние) объекта,
        который вы предоставили в текущее состояние.</wg:p>

    <wg:p>Например, состояние вашего компонента может содержать множество независимых переменных:</wg:p>

    <ce:code-example-19/>

    <wg:p>Далее вы можете обновить их независимо с помощью отдельных вызовов <code>setState()</code>:</wg:p>

    <ce:code-example-20/>

    <wg:p>Мерджинг неглубокий, поэтому <code>this.setState({users})</code> оставляет <code>this.state.posts</code>
        нетронутым, но окончательно заменяет <code>this.state.users</code>.</wg:p>

    <br/>
    <h2>2.6.5 Нисходящий поток данных</h2>

    <wg:p>Ни родительский, ни дочерний компоненты не могут знать, обладает ли определенный компонент состоянием
        или нет. Также они не заботятся о том, определен ли он как функция или класс.</wg:p>

    <wg:p>Вот почему состояние часто называется <b>локальным</b> или <b>инкапсулированным</b>.
        Оно недоступно для какого-либо компонента, за исключением того, который им владеет и устанавливает.</wg:p>

    <wg:p>Компонент может решить передать это состояние вниз как свойства
        <code>props</code> своим дочерним компонентам:</wg:p>

    <ce:code-example-21/>

    <wg:p>Это также работает и для пользовательских компонентов:</wg:p>

    <ce:code-example-22/>

    <wg:p>Компонент <code>FormattedDate</code> хотел бы получать <code>date</code> в
        его свойства и не хотел бы знать, пришло ли оно из состояния компонента <code>Clock</code>,
        из свойств компонента <code>Clock</code> или было указано вручную:</wg:p>

    <ce:code-example-23 codePenUrl="https://codepen.io/stzidane/pen/OgJjQM?editors=0010"/>

    <wg:p>Это принято называть «<b>сверху-вниз</b>», «<b>нисходящим</b>» или однонаправленым потоком данных.
        Любое состояние всегда находится во владении какого-либо компонента, и любые данные или UI, производные
        от этого состояния могут затрагивать только компоненты «<b>ниже</b>» их в дереве иерархии.</wg:p>

    <wg:p>Если вы представляете дерево компонентов как «водопад» свойств, то состояние каждого компонента
        является подобием дополнительного источника воды, который соединяется с водопадом в произвольной
        точке и также течет вниз.</wg:p>

    <wg:p>Для того чтобы показать, что все компоненты действительно изолированы,
        мы можем создать компонент <code>Application</code>, который отрисовывает <code>&lt;Timer/&gt;</code>:</wg:p>

    <ce:code-example-24 codePenUrl="https://codepen.io/stzidane/pen/dRyzKE?editors=0010"/>

    <wg:p>Каждый компонент <code>&lt;Timer/&gt;</code> устанавливает своё собственное значение и
        обновляется независимо.</wg:p>

    <wg:p>В приложениях React, обладает ли компонент состоянием или нет – является деталью реализации
        этого компонента, который может изменяться со временем. Вы можете использовать компоненты без
        состояния внутри компонентов, имеющих состояние и наоборот.</wg:p>
</lt:layout>