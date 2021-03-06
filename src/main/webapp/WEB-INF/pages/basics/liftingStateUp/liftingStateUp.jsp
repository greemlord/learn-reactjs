<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="lt" tagdir="/WEB-INF/tags/layout" %>
<%@taglib prefix="wg" tagdir="/WEB-INF/tags/widget" %>
<%@taglib prefix="ce" tagdir="/WEB-INF/tags/application/basics/lifting-state-up" %>
<%@taglib prefix="app" tagdir="/WEB-INF/tags/application" %>
<%@taglib prefix="ad" tagdir="/WEB-INF/tags/application/advertising" %>

<a name="pageStart"></a>
<lt:layout cssClass="black-line"/>
<lt:layout cssClass="page hello-world-example-page">
	<h1>2.11 Подъём состояния выше по иерархии</h1>

	<br/>

	<p class="introduction">
		Очень часто несколько компонентов должны отражать одни и те же данные, которые меняются с течением времени.
		В таких случаях следует поднимать состояние выше по иерархии: к их ближайшему общему предку.
		Давайте сделаем это в конкретном примере.
	</p>

	<br/>

	<p>В этом разделе мы создадим полицейский радар скорости, который
		сообщает о том, превышена ли скорость.</p>

	<p>Начнем с компонента под названием <code>SpeedDetector</code>. Он принимает текущую скорость <code>speed</code>
		и максимальную скорость <code>maxSpeed</code> в км/ч как свойства и выводит сообщение о том, превышена ли скорость:</p>

	<ce:code-example-1/>

	<p>Далее мы создадим компонент <code>SpeedRadar</code>, представляющий сам радар.
		Он будет отрисовывать элемент <code>&lt;input&gt;</code>, который позволяет нам вводить скорость и хранить её
		значение в <code>this.state.speed</code>.</p>
	
	<p>Пороговое значение скорости, при котором срабатывает радар будем хранить в
		константе <code>MAX_SPEED_IN_CITY</code> - максимально
		допустимая скорость движения в населённом пункте.</p>

	<ce:code-example-2 codePenUrl="https://codepen.io/stzidane/pen/GmPmmq?editors=0010"/>

	<br/>
	<br/>
	<div class="gray-line"></div>
	<h2>2.11.1 Добавим ещё один input</h2>
	<br/>

	<p>
		Сейчас мы можем задавать скорость только в <b>км/ч</b>. Пусть следующее наше требование - это наличие ещё
		одного <code>&lt;input&gt;</code>, который позволяет вводить скорость в <b>миль/ч</b>. Причём оба этих
		<code>&lt;input&gt;</code> должны быть синхронизированы.
	</p>

	<p>
		Чтобы достигнуть этой цели из компонента <code>SpeedRadar</code> следует извлечь компонент, который
		будет отвечать за установку скорости. Давайте сделаем это и назовём новый компонент <code>SpeedSetter</code>.
		Также добавим в него свойство <code>unit</code>, которое может принимать
		значения <code>KPH</code> или <code>MPH</code>.
	</p>

	<ce:code-example-2.1/>

	<p>
		Теперь можно отрефакторить компонент <code>SpeedRadar</code>, отрисовав в нём
		два отдельных установщика скорости.
	</p>

	<ce:code-example-2.2 codePenUrl="https://codepen.io/stzidane/pen/pmEBjQ?editors=0010"/>

	<p>
		Теперь у нас есть два элемента <code>&lt;input&gt;</code>. Но изменив скорость в одном из них,
		значение другого не поменяется. Это противоречит нашему требованию, которое гласит: <b>элементы ввода
		должны быть синхронизированы.</b>
	</p>

	<p>
		Кроме того, мы теперь не можем использовать компонент <code>SpeedDetector</code> в <code>SpeedRadar</code>,
		потому что последний ничего не знает о текущей скорости - она спрятана в компоненте <code>SpeedSetter</code>.
	</p>

	<br/>
	<br/>
	<div class="gray-line"></div>
	<h2>2.11.2 Функции конвертации скорости</h2>
	<br/>

	<p>
		Для правильной синхронизации, нам понадобятся функции конвертации
		скорости из <b>км/ч</b> в <b>миль/ч</b> и наоборот:
	</p>

	<ce:code-example-2.3/>

	<p>
		Эти функции конвертируют числа. Давайте напишем ещё одну функцию, которая будет принимать
		строковое значение скорости и функцию-конвертор, а возвращать - конвертированную скорость опять как строку.
		Мы будем использовать её, чтобы вычислить значение одного из <code>&lt;input&gt;</code>, основываясь на
		значении другого.
	</p>

	<p>
		Также она будет обеспечивать точность до двух знаков после запятой и возвращать пустую строку,
		если пользователь ввёл невалидное значение скорости. Для улучшения читабельности кода вынесем
		валидацию скорости в отдельную функцию:
	</p>

	<ce:code-example-2.4/>

	<p>
		К примеру вызов <code>convertSpeed('50', convertToKph)</code> вернёт значение <code>'31.06'</code>, а вызов
		<code>convertSpeed('Вася', convertToKph)</code> вернёт пустую строку.
	</p>

	<br/>
	<br/>
	<div class="gray-line"></div>
	<h2>2.11.3 Подъём состояния выше по иерархии</h2>
	<br/>

	<p>Сейчас оба наших компонента <code>SpeedSetter</code> хранят собственные значения
		скорости в своём локальном состоянии независимо друг от друга:</p>

	<ce:code-example-3/>

	<p>Согласно требованиям нам их нужно синхронизировать между собой. Как только
		будет обновлён установщик «<b>км/ч</b>», установщик «<b>миль/ч</b>» тут же отобразит
		конвертированное значение, и наоборот.</p>

	<p>
		<b>Чтобы несколько компонентов React могли совместно использовать одно состояние, нужно это
		состояние поместить в их ближайший общий предок.</b> Это называется «<b>подъём состояния</b>»
		(в оригинале «<b>lifting state up</b>»).
	</p>

	<p>
		Следуя этому принципу, давайте удалим локальное состояние из <code>SpeedSetter</code> и
		перенесем его в <code>SpeedRadar</code>.
	</p>

	<p>
		Если <code>SpeedRadar</code> владеет совместно используемым состоянием, то говорят, что он является
		единственным «<b>источником истины/достоверной информации</b>» для текущей скорости обоих установщиков.
		Он будет поручать установщикам использовать значения скорости, которые согласуются друг с другом. Каждый раз, когда
		свойства <code>props</code> обоих компонентов <code>SpeedSetter</code> будут приходить с родительского компонента
		<code>SpeedRadar</code>, оба установщика скорости всегда будут синхронизированы.
	</p>

	<p>Давайте пошагово рассмотрим как это работает.</p>

	<p>Для начала мы заменим <code>this.state.speed</code> на <code>this.props.speed</code>
		в компонентах <code>SpeedSetter</code>. Одновременно давайте представим, что
		<code>this.props.speed</code> уже существует, хотя в будущем нам нужно будет
		передать его из компонента <code>SpeedRadar</code>:</p>

	<ce:code-example-4/>

	<p>Мы знаем, что свойства <code>props</code> используются только для чтения. Когда скорость <code>speed</code> находилась в
		локальном состоянии установщика <code>SpeedSetter</code>, он мог вызвать <code>this.setState()</code>,
		чтобы её изменить. Однако сейчас скорость приходит из родительского компонента
		в объекте <code>props</code>, поэтому <code>SpeedSetter</code> больше не имеет над ней контроля.</p>

	<p>С этого момента наш компонент <code>SpeedSetter</code> становится «контролируемым» компонентом.
		По аналогии с тем, как DOM-элемент <code>&lt;input&gt;</code> принимает свойства <code>value</code> и <code>onChange</code>,
		компонент <code>SpeedSetter</code> может принимать свойства <code>speed</code> и <code>onChangeSpeed</code>
		из своего родительского компонента <code>SpeedRadar</code>.</p>

	<p>Теперь, когда <code>SpeedSetter</code> захочет обновить свою скорость <code>speed</code>,
		он вызовет <code>this.props.onChangeSpeed</code>:</p>

	<ce:code-example-5/>
	
	<app:alert title="Внимание!" type="warning">
		В пользовательских компонентах нет никакого особого требования к названиям свойств. В нашем случае это
		<code>speed</code> и <code>onChangeSpeed</code>, хотя мы могли бы назвать их
		как угодно, например, <code>value</code> и <code>onChange</code>, что не противоречит общему соглашению.
	</app:alert>

	<p>Свойства <code>onChangeSpeed</code> и <code>speed</code> будут предоставлены вместе родительским
		компонентом <code>SpeedRadar</code>. Он обработает изменение скорости с помощью модификации своего локального состояния.
		Это вызовет перерисовку обоих установщиков <code>SpeedSetter</code> с новыми значениями скорости.
		Очень скоро мы увидим новую реализацию <code>SpeedRadar</code>.</p>
	
	<ad:ad-content-banner-1/>

	<p>Перед погружением в анализ изменений кода компонента <code>SpeedRadar</code>, давайте прорезюмируем наши изменения в
		компоненте <code>SpeedSetter</code>. Мы удалили из него локальное состояние, и сейчас вместо чтения значения <code>this.state.speed</code>,
		мы читаем значение <code>this.props.speed</code>. А когда мы хотим выполнить изменение скорости, вместо вызова <code>this.setState()</code>,
		мы вызываем <code>this.props.onChangeSpeed()</code>, который будет предоставлен компонентом <code>SpeedRadar</code>:</p>

	<ce:code-example-6/>

	<p>Теперь давайте перейдем к компоненту <code>SpeedRadar</code>.</p>

	<p>Мы будем хранить текущую введенную скорость <code>speed</code> и единицу
		измерения <code>unit</code> в его локальном состоянии.
		Это состояние мы «<b>подняли</b>» из установщиков скорости. Теперь оно будет
		служить для них «<b>единственным источником истины</b>». Это минимальное представление
		всех данных, которые нам необходимо знать, чтобы отрисовать оба установщика.</p>

	<p>К примеру, если мы вводим значение <code>40</code> в установщик «Км/ч», то состояние компонента <code>SpeedRadar</code> будет:</p>

	<ce:code-example-7/>

	<p>Если в поле «Миль/ч» мы введём значение <code>80</code>, то состояние <code>SpeedRadar</code> будет:</p>

	<ce:code-example-8/>

	<p>
		Мы могли бы хранить значения обоих установщиков, но это излишне.
		Достаточно хранить значение недавнего установщика и единицу измерения, которую он представляет.
		Далее мы можем определить значение другого установщика, основываясь на текущей
		скорости <code>speed</code> и его единице измерения <code>unit</code>.
	</p>

	<p>Теперь наши установщики скорости синхронизированы, так как их значения вычислены из одного и того же состояния:</p>

	<ce:code-example-9 codePenUrl="https://codepen.io/stzidane/pen/dWEZro?editors=0010"/>
	
	<p>
		Мы поменяли название константы <code>MAX_SPEED_IN_CITY</code> на <code>MAX_SPEED_IN_CITY_IN_KPH</code>,
		так как теперь важно знать единицу измерения скорости.
	</p>

	<p>Сейчас не имеет значения в какое поле вы вводите значение: <code>this.state.speed</code> и <code>this.state.unit</code> в
		компоненте <code>SpeedRadar</code> будут обновлены. Один из элементов <code>input</code> получает введённое пользователем
		значение, и оно сохраняется в состоянии как есть. На основании него будет вычислено значение другого <code>input</code>.</p>

	<p>Давайте прорезюмируем, что происходит, когда мы редактируем <code>input:</code></p>
	
	<ul>
		<li>
			<p>
				React вызывает функцию, указанную в атрибуте <code>onChange</code> DOM-элемента <code>&lt;input&gt;</code>.
				В нашем случае, это метод <code>onChange</code> в компоненте <code>SpeedSetter</code>.
			</p>
		</li>
		
		<li>
			<p>
				Метод <code>onChange</code> компонента <code>SpeedSetter</code> вызывает
				<code>this.props.onChangeSpeed()</code> с новым желаемым значением скорости.
				Его свойства, включая <code>onChangeSpeed</code>, были предоставлены
				родительским компонентом - <code>SpeedRadar</code>.
			</p>
		</li>
		
		<li>
			<p>
				Когда <code>SpeedRadar</code> отрисовывался в последний раз, он указал, что <code>onChangeSpeed</code>
				компонента <code>SpeedSetter</code> с единицами «Км/ч» является методом <code>onChangeSpeedInKph</code>
				компонента <code>SpeedRadar</code>, а <code>onChangeSpeed</code> компонента <code>SpeedSetter</code> с единицами «Миль/ч»
				соответственно является методом <code>onChangeSpeedInMph</code>.
				Таким образом, в зависимости от того, какой <code>&lt;input&gt;</code> мы отредактировали,
				будет вызван тот или иной метод компонента <code>SpeedRadar</code>.
			</p>
		</li>
		
		<li>
			<p>
				Внутри этих методов, компонент <code>SpeedRadar</code> запрашивает у React перерисовку, используя
				вызов <code>this.setState()</code> с новым введенным значением скорости и её единицей измерения.
			</p>
		</li>
		
		<li>
			<p>
				React вызывает метод <code>render()</code> компонента <code>SpeedRadar</code>, чтобы понять как должен выглядеть UI.
				Значения обоих элементов <code>&lt;input&gt;</code> пересчитываются, на основании текущих значения скорости и
				единицы измерения. Здесь же выполняется и конвертация скорости.
			</p>
		</li>
		
		<li>
			<p>
				React индивидуально вызывает методы <code>render()</code> компонентов <code>SpeedSetter</code> с их новыми свойствами,
				указанными компонентом <code>SpeedRadar</code>. Так он узнает, как должен выглядеть их UI.
			</p>
		</li>
		
		<li>
			<p>
				React DOM обновляет DOM, чтобы привести в соответствие значения установщиков. Элемент
				<code>&lt;input&gt;</code>, который мы только что отредактировали, принимает своё текущее значение, а второй
				<code>&lt;input&gt;</code> обновляется до значения скорости после конвертации.
			</p>
		</li>
	</ul>

	<p>Каждое обновление проходит по точно такому же алгоритму, так что элементы
		<code>&lt;input&gt;</code> всегда остаются синхронизированными.</p>
	
	<br/>
	<br/>
	<div class="gray-line"></div>
	<h2>2.11.4 Извлеченные уроки</h2>
	<br/>

	<p>В приложении React должен существовать лишь один «<b>источник истины</b>» для любых
		данных, которые изменяются с течением времени. Обычно состояние сначала добавляется в компонент,
		которому оно необходимо для отрисовки. Затем, если другие компоненты тоже требуют данные этого
		состояния, вы можете «поднять» его к их ближайшему общему предку. Не пытайтесь синхронизировать состояние между различными
		компонентами, вместо этого полагайтесь на нисходящий поток данных.</p>

	<p>Подъём состояния приводит к большему объёму «шаблонного» кода, по сравнению с подходами,
		использующими двойную привязку. Но есть и выйгрыш - на поиск и изоляцию багов уходит меньше времени.
		Как только какое-нибудь состояние «начало жить» в компоненте и
		этот компонент единственный, кто может его изменять, область существования багов значительно
		уменьшается. Плюс ко всему, вы можете реализовать любую кастомную логику, чтобы отклонить или
		преобразовать пользовательский ввод.</p>

	<p>Если что-либо может быть извлечено и из состояния, и из свойств, возможно, это не должно
		находиться в состоянии. К примеру, вместо хранения в состоянии <code>kphValue</code> и <code>mphValue</code>, мы храним
		только последнее введённое значение скорости <code>speed</code> и ее единицу измерения <code>unit</code>.
		Значение другого элемента <code>input</code> всегда может быть вычислено из них в методе <code>render()</code>. Это позволяет
		нам убрать или применить округление к другому полю без потери точности данных, введенных пользователем.</p>

	<p>Если вы видите что-то неправильное в UI, вы можете использовать
		<b><a href="https://github.com/facebook/react-devtools">React Developer Tools</a></b>, чтобы
		проинспектировать свойства и подняться вверх по дереву до тех пор, пока не найдете компонент,
		ответственный за обновление состояния. Это позволит вам выследить источник багов.</p>
</lt:layout>

<c:url var="prevPageUrl" value="forms"/>
<c:url var="nextPageUrl" value="composition-vs-inheritance"/>
<app:page-navigate prevPageUrl="${prevPageUrl}"
									 pageStartAncor="pageStart"
									 nextPageUrl="${nextPageUrl}"/>