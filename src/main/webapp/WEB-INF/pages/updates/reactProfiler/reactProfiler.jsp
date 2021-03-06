<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/updates/updateOnAsyncRendering" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>

<c:url var="profilerApiUrl" value="https://github.com/reactjs/rfcs/pull/51"/>
<c:url var="timeSlicingAndSuspenceUrl" value="https://reactjs.org/blog/2018/03/01/sneak-peek-beyond-react-16.html"/>
<c:url var="fbMeProfilingUrl" value="https://gist.github.com/bvaughn/25e6233aeb1b4f0cdb8d8366e54a3977"/>

<c:url var="img1Url" value="https://reactjs.org/static/devtools-profiler-tab-4da6b55fc3c98de04c261cd902c14dc3-53c76.png"/>
<c:url var="img2Url" value="https://reactjs.org/static/start-profiling-bae8d10e17f06eeb8c512c91c0153cff-53c76.png"/>
<c:url var="img3Url" value="https://reactjs.org/static/stop-profiling-45619de03bed468869f7a0878f220586-53c76.png"/>
<c:url var="img4Url" value="https://reactjs.org/static/commit-selector-bd72dec045515d59be51c944e902d263-8ef72.png"/>
<c:url var="img5Url" value="https://reactjs.org/filtering-commits-683b9d860ef722e1505e5e629df7ef7e.gif"/>
<c:url var="img6Url" value="https://reactjs.org/zoom-in-and-out-39ba82394205242af7c37ccb3a631f4d.gif"/>
<c:url var="img7Url" value="https://reactjs.org/see-which-props-changed-cc2a8b37bbce52c49a11c2f8e55dccbc.gif"/>
<c:url var="img8Url" value="https://reactjs.org/static/ranked-chart-0c81347535e28c9cdef0e94fab887b89-acf85.png"/>
<c:url var="img9Url" value="https://reactjs.org/static/component-chart-d71275b42c6109e222fbb0932a0c8c09-acf85.png"/>
<c:url var="img10Url" value="https://reactjs.org/see-all-commits-for-a-fiber-99cb4321ded8eb0c21ae5fc673878563.gif"/>
<c:url var="img11Url" value="https://reactjs.org/static/no-render-times-for-selected-component-8eb0c37a13353ef5d9e61ae8fc040705-acf85.png"/>
<c:url var="img12Url" value="https://reactjs.org/static/interactions-a91a39ac076b71aa7a202aaf46f8bd5a-acf85.png"/>
<c:url var="img13Url" value="https://reactjs.org/static/interactions-for-commit-9847e78f930cb7cf2b0f9682853a5dbc-acf85.png"/>
<c:url var="img14Url" value="https://reactjs.org/navigate-between-interactions-and-commits-7c66e7686b5242473c87b3d0b4576cf3.gif"/>
<c:url var="img15Url" value="https://reactjs.org/static/no-profiler-data-multi-root-0755492a211f5bbb775285c0ff2fdfda-53c76.png"/>
<c:url var="img16Url" value="https://reactjs.org/select-a-root-to-view-profiling-data-bdc30593d414b5c8d2ae92027ed11940.gif"/>
<c:url var="img17Url" value="https://reactjs.org/static/no-timing-data-for-commit-63b2fb6298feecb179272c467020ed95-acf85.png"/>
<c:url var="videoUrl" value="https://youtu.be/nySib7ipZdk"/>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page async-rendering-update-page">
    <h1>Представляем профайлер React</h1>

    <p><b>10 Сентября, 2018. Brian Vaughn (Брайан Вон)</b></p>

    <p>
        React 16.5 добавляет поддержку нового плагина для профилирования: DevTools.
        Данный плагин использует экспериментальный <a href="${profilerApiUrl}"><b>Profiler API-интерфейс</b></a> React для сбора
        информации о времени для каждого отображаемого компонента, для выявления узких мест
        производительности в приложениях React. Он будет полностью совместим с нашими функциями
        временн<b>о</b>й нарезки (<a href="${timeSlicingAndSuspenceUrl}"><b>time slicing</b></a>) и
        приостановки (<a href="${timeSlicingAndSuspenceUrl}"><b>suspence</b></a>).
    </p>

    <p>Данная статья охватывает следующие темы:</p>

    <ul>
        <li><a href="#s1"><b>Профилирование приложения</b></a></li>
        <li><a href="#s2"><b>Просмотр данных о производительности</b></a>
            <ul>
                <li><a href="#s21"><b>Просмотр фиксаций</b></a></li>
                <li><a href="#s22"><b>Фильтрация фиксаций</b></a></li>
                <li><a href="#s23"><b>Пламенная диаграмма</b></a></li>
                <li><a href="#s24"><b>Диаграмма ранжирования</b></a></li>
                <li><a href="#s25"><b>Диаграмма компонента</b></a></li>
                <li><a href="#s26"><b>Взаимодействия</b></a></li>
            </ul>
        </li>
        <li><a href="#s3"><b>Исправление проблем</b></a>
            <ul>
                <li><a href="#s31"><b>Данные о профилировании не были записаны для выбранного корня</b></a></li>
                <li><a href="#s32"><b>Отсутствуют данные для отображения по выбранной фиксации</b></a></li>
            </ul>
        </li>
        <li><a href="#s4"><b>Видео для более глубокого погружения</b></a></li>
    </ul>

    <br/>
    <a name="s1"></a>
    <h2>Профилирование приложения</h2>

    <br/>
    <p>DevTools отобразит вкладку «Profiler» для приложений, поддерживающих новый API профилирования:</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img1Url}"/>
    </p>

    <br/>
    <app:alert type="warning" title="Внимание!">
        <code>react-dom 16.5+</code> поддерживает профилирование в режиме <code>DEV</code>. <code>Production</code> профилирование
        также доступно как <code>react-dom/profiling</code>. Подробнее о том, как использовать
        этот бандл в <a href="${fbMeProfilingUrl}"><b>fb.me/react-profiling</b></a>
    </app:alert>

    <p>Сначала панель «Profiler» будет пуста. Нажмите кнопку записи, чтобы начать профилирование:</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img2Url}"/>
    </p>

    <br/>
    <p>После того, как вы начали запись, DevTools будет автоматически собирать информацию о производительности
        каждый раз, когда ваше приложение отрисовывается. Используйте свое приложение, как обычно.
        Когда вы закончите профилирование, нажмите кнопку «Стоп».</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img3Url}"/>
    </p>

    <br/>
    <p>Предполагая, что ваше приложение отрисовывается хотя бы один раз при профилировании,
        DevTools покажет несколько вариантов просмотра данных о производительности.
        Далее рассмотрим каждый из них.</p>

    <br/>
    <a name="s2"></a>
    <h2>Просмотр данных о производительности</h2>

    <br/>
    <a name="s21"></a>
    <h3>Просмотр фиксаций</h3>
    <br/>

    <p>Концептуально, React работает в два этапа:</p>

    <ul>
        <li><b>Фаза отрисовки/рендеринга (render phase)</b> определяет, какие изменения необходимо произвести.
            Во время этой фазы React вызывает render, а затем сравнивает результат с предыдущим
            результатом вызова этого метода.</li>
        <li><b>Фаза фиксации/коммита (commit phase)</b> - здесь React применяет любые изменения. (В случае React DOM - это
            когда React вставляет, обновляет и удаляет узлы DOM.) Во время данной фазы React также
            вызывает методы ЖЦ, такие как <code>componentDidMount</code> и <code>componentDidUpdate</code>.</li>
    </ul>

    <p>Профайлер DevTools группирует информацию о фиксациях. Фиксации отображаются
        на гистограмме в верхней части профайлера:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img4Url}"/>
    </p>

    <br/>
    <p>Каждый столбик на диаграмме представляет собой одиночную фиксацию. Выбранная в данный момент
        фиксация окрашена черным цветом. Вы можете кликнуть на столбик (или использовать стрелки влево / вправо),
        чтобы выбрать другую фиксацию.</p>

    <p>Цвет и высота каждого столбика соответствуют тому, сколько времени требуется для выполнения
        фиксации. (Более высокие, желтые столбики требуют больше, чем более низкие голубые.)</p>

    <br/>
    <a name="s22"></a>
    <h3>Фильтрация фиксаций</h3>
    <br/>

    <p>Чем дольше вы производите профилирование, тем больше случаев ваше приложение будет отображать.
        В некоторых случаях вы можете получить слишком много фиксаций для простого процесса. В помощь профайлер
        предлагает механизм фильтрации. Используйте его, чтобы
        указать пороговое значение. Профайлер скроет все фиксации, которые были быстрее этого значения.</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img5Url}"/>
    </p>

    <br/>
    <a name="s23"></a>
    <h3>Пламенная диаграмма</h3>
    <br/>

    <p>Пламенная диаграмма представляет состояние вашего приложения для конкретной фиксации.
        Каждый столбик на диаграмме представляет собой компонент React (например, <code>App</code>, <code>Nav</code>).
        Размер и цвет столбика показывают, сколько времени потребовалось для отрисовки компонента и
        его потомков. (Ширина столбика показывает, сколько времени прошло
        <b>с того момента, когда компонент в последний раз отрисовывался</b>, а цвет показывает, сколько времени было потрачено <b>в
        рамках текущей фиксации</b>.)</p>

    <br/>
    <app:alert type="warning" title="Внимание!">
        Ширина столбика указывает, сколько времени потребовалось для отрисовки компонента (и его потомков),
        с момента последнего отображения. Если компонент не перерисовывался как часть этой фиксации, время
        представляет предыдущую отрисовку. Чем шире компонент, тем дольше происходит отрисовка.
        <br/>
        <br/>
        Цвет полосы показывает, сколько времени заняла отрисовка компонента (и его потомки) в выбранной
        фиксации. Желтые компоненты занимают больше времени, голубые - меньше, а серые компоненты во время
        этой фиксации не отрисовывались вообще.
    </app:alert>

    <br/>
    <p>Например, фиксация, показанная выше, заняла в общей сложности 18,4 мс. Компонент <code>Router</code>
        был «самым дорогим» для отрисовки (потратив 18,4 мс). Большая часть этого времени пришлась
        на двух потомков: <code>Nav</code> (8,4 мс) и <code>Route</code> (7,9 мс). Остальное время было разделено между
        оставшимися потомками или было затрачено в собственном методе отрисовки компонента.</p>

    <p>Вы можете увеличивать или уменьшать масштаб на пламенной диаграмме, нажимая на компоненты:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img6Url}"/>
    </p>

    <br/>
    <p>Помимо прочего нажатие на компонент приведет к его выбору и покажет на правой боковой панели информацию,
        которая включает в себя его свойства и состояние во время данной фиксации. Вы можете их подробно
        просмотреть, чтобы больше узнать о том, что компонент действительно отображал во время фиксации:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img7Url}"/>
    </p>

    <br/>
    <p>На приведенном выше рисунке показано, что значение <code>state.scrollOffset</code> изменяется между
        фиксациями. Вероятно, это приводит к перерисовке компонента <code>List</code>.</p>

    <br/>
    <a name="s24"></a>
    <h3>Диаграмма ранжирования</h3>
    <br/>

    <p>Диаграмма ранжирования представляет одиночную фиксацию. Каждый столбик на диаграмме
        представляет собой компонент React (например, <code>App</code>, <code>Nav</code>). Диаграмма упорядочена так,
        что компоненты, которые занимают больше времени по отрисовке, расположены выше.</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img8Url}"/>
    </p>

    <br/>
    <app:alert type="warning" title="Внимание!">
        Время отрисовки компонента включает время, затрачиваемое на отрисовку его потомков,
        поэтому компоненты, которые расходуют больше всего времени на отрисовку, обычно
        находятся ближе к вершине дерева.
    </app:alert>

    <p>Как и в пламенной диаграмме, вы можете увеличивать или уменьшать
        масштаб на диаграмме ранжирования, нажимая на компоненты.</p>

    <br/>
    <a name="s25"></a>
    <h3>Диаграмма компонента</h3>
    <br/>

    <p>Иногда полезно видеть, сколько раз отображался конкретный компонент во время профилирования.
        Диаграмма компонента предоставляет эту информацию в виде гистограммы. Каждый столбик на диаграмме
        представляет собой момент времени, когда компонент отрисовывался. Цвет и высота каждого столбца соответствуют
        тому, как долго компонент выполнял отрисовку относительно других компонентов в определенной фиксации.</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img9Url}"/>
    </p>

    <br/>
    <p>Приведенная выше диаграмма показывает, что компонент <code>List</code> отрисовывался 11 раз. Она также
        показывает, что каждый раз, когда он отображался, это был самый «дорогой» компонент в фиксации.</p>

    <p>Чтобы просмотреть данную диаграмму, дважды щелкните по компоненту или выберите компонент и щелкните
        синий значок гистограммы в правой части панели. Вы можете вернуться к предыдущей диаграмме, нажав
        кнопку «x» в правой части панели. Вы также можете дважды щелкнуть по определенном столбике, чтобы
        просмотреть дополнительную информацию по данной фиксации.</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img10Url}"/>
    </p>

    <br/>
    <p>Если выбранный компонент вообще не отрисовывался во время сеанса
        профилирования, будет показано следующее сообщение:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img11Url}"/>
    </p>

    <br/>
    <a name="s26"></a>
    <h3>Взаимодействия</h3>
    <br/>

    <p>React недавно добавил еще один экспериментальный API для отслеживания причины
        обновления. "Взаимодействия", отслеживаемые с помощью этих API, также будут показаны в профайлере:</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img12Url}"/>
    </p>

    <br/>
    <p>На изображении выше показан сеанс профилирования, который отследил четыре взаимодействия.
        Каждая строка представляет собой отслеженное взаимодействие. Цветные точки вдоль строки
        представляют собой фиксации, которые были связаны с этим взаимодействием.</p>

    <p>Вы также можете увидеть, какие взаимодействия были отслежены для конкретной фиксации
        из пламенной диаграммы и диаграммы ранжирования:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img13Url}"/>
    </p>

    <br/>
    <p>Вы можете перемещаться между взаимодействиями и фиксациями, кликая по ним:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img14Url}"/>
    </p>

    <br/>
    <p>API трассировки по-прежнему является новым, и мы рассмотрим его более подробно в будущем посте.</p>

    <br/>
    <a name="s3"></a>
    <h2>Исправление проблем</h2>

    <br/>
    <a name="s31"></a>
    <h3>Данные о профилировании не были записаны для выбранного корня</h3>
    <br/>

    <p>Если ваше приложение имеет несколько «корней», после профилирования может появиться следующее сообщение:</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img15Url}"/>
    </p>

    <br/>
    <p>Это сообщение указывает, что данные о производительности не были записаны для корня,
        выбранного в панели «Elements». В этом случае попробуйте выбрать другой корень в этой панели,
        чтобы просмотреть для него данные профилирования:</p>

    <br/>
    <p class="text-center" style="overflow-x: auto">
        <img src="${img16Url}"/>
    </p>

    <br/>
    <a name="s32"></a>
    <h3>Отсутствуют данные для отображения по выбранной фиксации</h3>
    <br/>

    <p>Иногда фиксация может быть настолько быстрой, что <code>performance.now()</code> не дает
        DevTools какую-либо значимую информацию о времени. В этом случае будет показано следующее сообщение:</p>

    <p class="text-center" style="overflow-x: auto">
        <img src="${img17Url}"/>
    </p>

    <br/>
    <a name="s4"></a>
    <h2>Видео для более глубокого погружения</h2>

    <br/>
    <p><a href="${videoUrl}"><b>Следующее видео</b></a> демонстрирует, как профайлер React может использоваться для обнаружения и
        устранения узких мест производительности в реальном приложении React.</p>
    <br/>

</lt:layout>

<c:url var="prevPageUrl" value="derived-state-necessity"/>
<c:url var="nextPageUrl" value="create-react-app-2.0"/>

<app:page-navigate
        pageStartAncor="pageStart"
        prevPageUrl="${prevPageUrl}"
        nextPageUrl="${nextPageUrl}"
/>