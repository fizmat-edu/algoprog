import contest from "../../lib/contest"
import label from "../../lib/label"
import page from "../../lib/page"
import problem from "../../lib/problem"
import topic from "../../lib/topic"

module16475 = () ->
    page("Теория по логарифмическим сортировкам", String.raw"""
        <div class="box generalbox generalboxcontent boxaligncenter clearfix"><h2>Логарифмические сортировки</h2>
        <p>Логарифмические сортировки — это алгоритмы сортировки, имеющие сложность $O(N \log N)$ и использующие только сравнения элементов. Они позволяют за одну секунду отсортировать массив длиной 100&nbsp;000 — 1000&nbsp;000. Именно их вам и стоит использовать в большинстве задач, требующих сортировки.</p>
        
        <p>Существует огромное множество разных логарифмических сортировок, но реально широко используются три:</p>
        <ul>
        <li>Быстрая сортировка, она же QuickSort, сортировка Хоара, быстрая сортировка Хоара или просто qsort;</li>
        <li>Сортировка слиянием (MergeSort);</li>
        <li>Сортировка кучей (иногда говорят «пирамидой»), она же хипсорт (heapsort).</li>
        </ul>
        <p>В этом тексте я опишу сортировку слиянием и быструю сортировку. Сортировка кучей будет в теме про кучу в уровне 5А.</p>
        
        <h3>Быстрая сортировка Хоара (QuickSort)</h3>
        <h4>Идея</h4>
        <p>Идея сортировки очень простая. Пусть нам надо отсортировать некоторый кусок массива. Возьмем произвольный элемент в этом куске массива, пусть этот элемент равен $x$. Переставим остальные элементы этого куска так, чтобы сначала шли все элементы $\leq x$, а потом все элементы $\geq x$. (Есть много вариаций на счет того, где тут допускать нестрогое неравенство, а где требовать строгого неравенства.) Это можно сделать за один проход по массиву. После этого осталось отсортировать оба полученных куска по отдельности, что мы и сделаем двумя <i>рекурсивными запусками</i>.</p>
        
        <p>Как именно сделать требуемое разбиение? Обычно делают так: запускают с двух концов рассматриваемого куска массива два указателя. Сначала идут одним указателем слева направо, начиная с левого конца, пропуская числа, которые $&lt;x$ — они вполне себе находятся на своих местах. Когда находиться элемент, который $\geq x$, то указатель останавливается. После этого идут вторым указателем справа налево, начиная с правого конца, пропуская элементы, которые $&gt;x$ — они тоже вполне на своих местах. Когда находят элемент $\leq x$, его меняют местами с тем элементом, который был найден первым указателем. После этого оба этих элемента тоже получаются на своих местах, и указателями идут дальше. И так до тех пор, пока указатели не поменяются местами.</p>
        
        <h4>Реализация</h4>
        <p>Классическая реализация следующая (я взял ее <a href="https://rosettacode.org/wiki/Sorting_algorithms/Quicksort#Pascal">отсюда</a>):</p>
        <pre>// сортируем массив A на участке от left до right
        procedure quicksort(left, right : integer);
        var i, j :integer;
            tmp, x :integer;
        begin
          i:=left;
          j:=right;
          x := A[(left + right) div 2]; // выбираем x, см. обсуждение этой строки ниже
          repeat
            while x&gt;A[i] do inc(i); // пропускаем те элементы, что стоят на своих местах
            while x&lt;A[j] do dec(j); // пропускаем те элементы, что стоят на своих местах
            if i&lt;=j then begin
              // нашли два элемента, которые не на своих местах
              // --- меняем их местами
              tmp:=A[i];
              A[i]:=A[j];
              A[j]:=tmp;
              dec(j);
              inc(i);
            end;
          until i&gt;j;
          // если в левой части больше одного элемента, то отсортируем ее
          if left&lt;j then quicksort(left,j);
          // аналогично с правой
          if i&lt;right then quicksort(i,right);
        end;
        </pre>
        
        <p>И идея, и реализация выглядит просто, но на самом деле здесь полно подводных камней. Попробуйте сейчас осознать этот код, понять его, а потом закройте эту страницу и напишите программу — почти наверняка получившаяся программа работать не будет или будет не всегда. Более того, если вы попытаетесь понять, что в вашей программе не так, и будете сравнивать ее с кодом выше — вы не поймете, почему отличия так важны.</p>
        
        <p>Поэтому, на мой взгляд, единственный способ научиться писать quicksort, по крайней мере на вашем текущем уровне, — это найти точно работающую реализацию и <i>выучить ее наизусть</i> (кстати, я не уверен на 100%, что код, приведенный выше, действительно работает). Может быть, когда вы станете совсем крутыми, вы сможете понять все подводные камни quicksort'а, но вряд ли сейчас. Если же вы не выучили ее наизусть, то настоятельно не рекомендую вам ее писать в реальных задачах. Лучше освойте сортировку слиянием, про которую я пишу ниже.</p>
        
        <h4>Сложность</h4>
        <p>Какова сложность quicksort'а? Если немного подумать головой, то понятно, что <i>в худшем случае</i> ее сложность — $O(N^2)$. Действительно, если каждый раз нам будет не везти и каждый раз мы будем в качестве $x$ выбирать <i>наименьший</i> элемент текущего куска, то каждый раз длина сортируемого куска будет уменьшаться лишь на единицу, и глубина рекурсии получится $N$, и на каждом уровне рекурсии будет примерно $N$ действий — итого $O(N^2)$</p>
        
        <p>Но при этом быстрая сортировка — редчайший пример алгоритма, у которого сложность <i>в среднем</i> лучше, чем <i>в худшем</i> случае. А именно, давайте для начала посмотрим на <i>идеальный</i> случай. В идеальном на каждой итерации массив будет делиться ровно пополам, и глубина рекурсии будет всего лишь $\log N$. Итого сложность $O(N \log N)$. Утверждается, что <i>в среднем</i> (т.е. если входные данные случайны) сложность тоже будет $O(N \log N)$.</p>
        
        <p>Правда, есть подстава: входные данные никогда не случайны. Если мы выбираем $x$ вполне определенным способом, например, как в примере выше — всегда <i>средний</i> элемент массива, то злой пользователь (или злое жюри) сможет всегда подобрать такой пример, чтобы наша сортировка работала совсем плохо, т.е. за $O(N^2)$. (А еще хуже было бы брать всегда самый первый или самый последний элемент — тогда не только злой пользователь мог бы подобрать специальный тест, но и просто если входные данные <i>уже</i> отсортированы, а такое бывает и не у злых пользователей, то сортировка отработает за $O(N^2)$).</p>
        
        <p>Против этого можно бороться, выбирая каждый раз элемент <i>случайным</i> образом, т.е. с помощью <code>random</code>. Только не забудьте сделать <code>randomize</code>, чтобы предугадать, какой вы выберете элемент, было реально сложно.</p>
        
        <h4>$k$-я порядковая статистика</h4>
        <p>Помимо собственно сортировки, у идей quicksort'а есть еще одно применение. Пусть нам дан неотсортированный массив и число $k$. Зададимся вопросом: какое число будет стоять на $k$-м месте, если массив отсортировать? Это число называется $k$-й порядковой статистикой (т.е, например, 137-й порядковой статистикой называется число, которое будет стоять на 137-м месте).</p>
        
        <p>Чтобы найти $k$-ю порядковую статистику, можно, конечно, отсортировать массив — сложность решения будет $O(N\log N)$. Но можно поступить проще. Разобьем массив на две части, как в quicksort'е. Quicksort дальше рекурсивно запускается для обеих полученных частей, но нам этого не надо — мы знаем, сколько элементов в какой части и потому знаем, в какую часть попадает $k$-й элемент. Поэтому нам достаточно сделать только один рекурсивный запуск. В итоге можно доказать, что сложность в среднем получается $O(N)$.</p>
        
        <h3>Сортировка слиянием</h3>
        
        <h4>Слияние двух массивов</h4>
        <p>Сначала рассмотрим более простую задачу. Пусть у нас есть два <i>уже отсортированных</i> массива, и нам надо объединить их в один отсортированный. Например, если есть два массива</p>
        <pre>a1 = 1 6 7 9
        a2 = 2 3 7 10
        </pre>
        <p>то должен получиться массив</p>
        <pre>res = 1 2 3 6 7 7 9 10</pre>
        <p>Как это сделать? Очевидно, что на первом месте должен оказаться либо первый элемент первого массива, либо первый элемент второго массива — т.к. все остальные числа их больше. Выберем тот элемент, который меньше, поставим в выходной массив и удалим при этом его из соответствующего исходного массива:
        </p><pre>a1 =   6 7 9
        a2 = 2 3 7 10
        res = 1
        </pre>
        <p>После этого сравним те два числа, которые теперь оказались в начале исходных массивов (в данном случае 2 и 6). Опять выберем наименьшее из них и переместим его в итоговый массив, и т.д. В итоге за один проход по каждому из исходных массивов мы получим отсортированный массив.</p>
        
        <p>Пишется это достаточно легко. Конечно, мы не будет на самом деле удалять элементы из исходных массивов, а просто мы заведем указатели (индексы) <code>i1</code> и <code>i2</code>, которые будут показывать, какие элементы в обоих исходных массивах являются текущими. Получается следующий код:</p>
        <pre>i1:=1;
        i2:=1;
        for i:=1 to n1+n2 do // n1, n2 -- количество элементов в исходных массивах
            if (i1&lt;=n1) and ( (i2&gt;n2) or (a1[i1]&lt;a2[i2]) ) then begin
                res[i]:=a1[i1];
                inc(i1);
            end else begin
                res[i]:=a2[i2];
                inc(i2);
            end;
        </pre>
        <p>Тут все просто, кроме условия в if. Казалось бы, там должно быть банальное <code>if a1[i1]&lt;a2[i2]</code> — но нет, дело в том, что в какой-то момент один из исходных массивов кончится, и так просто сравнивать не получится. Поэтому там стоит чуть более сложное условие. А именно, когда надо брать элемент из первого массива? Ну, во-первых, конечно, только в том случае, если первый массив еще не кончился: <code>i1&lt;=n1</code>. Во-вторых, если первый массив не кончился, то надо посмотреть на второй массив. Либо второй массив кончился (и тогда точно берем из первого массива), либо он не кончился, и тогда уже надо честно сравнить <code>a1[i1]</code> и <code>a2[i2]</code>. Поэтому ничего особенно сложного в условии if'а нет, все достаточно понятно, если помнить, что массивы могут заканчиваться.</p>
        
        <h4>Собственно сортировка слиянием</h4>
        <p>Теперь исходную задачу сортировки неотсортированного массива можно решить так. Разобьем исходный массив на две половинки. <i>Рекурсивно</i> отсортируем каждую, запустив этот же алгоритм. После этого мы имеем две отсортированные половинки — сольем их так, как описано выше.</p>
        
        <p>Это пишется достаточно легко:</p>
        <pre>var a:array[1..100000] of integer; // массив, который сортируем
            aa:array[1..100000] of integer; // вспомогательный массив
        
        procedure sort(l,r:integer); // сортируем кусок массива от l до r включительно
        var i,i1,i2,o:integer;
        begin
        if l&gt;=r then exit; // если кусок короткий, то сортировать нечего
                           // это же — условие выхода из рекурсии
        o:=(l+r) div 2;
        // разбили на две половинки: (l..o) и (o+1..r)
        // отсортируем
        sort(l,o);
        sort(o+1,r);
        // сольем во временный массив
        i1:=l;
        i2:=o+1;
        for i:=l to r do 
            if (i1&lt;=o)and((i2&gt;r)or(a[i1]&lt;a[i2])) then begin
                aa[i]:=a[i1];
                inc(i1);
            end else begin
                aa[i]:=a[i2];
                inc(i2);
            end;
        // перенесем из временного обратно в основной массив
        for i:=l to r do
            a[i]:=aa[i];
        end;
        </pre>
        <p>В принципе, тут все понятно. Надо только аккуратно записать условие в if'е, не запутавшись, где строгое, а где нестрогое неравенство, но, т.к. вы понимаете аргументацию ("а вдруг массив кончился?"), то всё просто. Кроме того, не запутайтесь, где <code>o</code>, а где <code>o+1</code>, но это тоже просто, т.к. <code>o</code> — последний элемент первой половины массива.</p>
        
        <p>Конечно, сортировку слиянием можно написать несколько быстрее, но обычно это не требуется.</p>
        
        <h4>Сложность</h4>
        <p>Со сложностью сортировки слиянием всё проще. Каждая процедура <code>sort</code> работает за линейное время от длины сортируемого куска, не учитывая рекурсивные запуски. На верхнем уровне рекурсии мы получаем один запуск от всего массива — время $O(N)$. На следующем уровне рекурсии мы получаем два запуска на двух половинках массива, но в сумме эти половинки составляют целый массив, поэтому в сумме время этих двух запусков тоже $O(N)$. На третьем уровне у нас четыре четвертинки, которые в сумме тоже дают $O(N)$. Уровней всего, как несложно видеть, $\log N$, итого получаем сложность $O(N \log N)$.
        
        </p><h4>Подсчет числа инверсий</h4>
        <p>У сортировки слиянием есть следующее применение. Пусть есть неотсортированный массив. <i>Инверсией</i> (или <i>беспорядком</i>) в этом массиве назовем любые два элемента, которые друго относительно друга стоят в неправильном порядке. Например, в массиве 4 3 5 2 есть четыре инверсии: 4 идет раньше 3; 4 идет раньше 2; 3 идет раньше 2; 5 идет раньше 2. </p>
        
        <p>Как можно посчитать количество инверсий? Можно просто проверить все пары, но это будет $O(N^2)$. А можно воспользоваться какой-нибудь сортировкой. А именно, когда в какой-нибудь сортировке мы переставляем какой-нибудь элемент, то посмотрим, сколько других элементов, которые больше его, но которые шли раньше в исходном порядке, он "обогнал". Во многих случаях это получается именно число инверсий, которые "исчезли" в нашем массиве после этой перестановки. В конце в получившемся отсортированном массиве инверсий не будет, поэтому вот сколько в сумме исчезло инверсий, столько их изначально и было.</p>
        
        <p>Самый простой пример — сортировка пузырьком. Каждый раз, когда она меняет два элемента местами, исчезает одна инверсия. Поэтому количество обменов в сортировке пузырьком — это как раз число инверсий. Аналогично в сортировке вставками: когда мы берем очередной элемент и передвигаем его на несколько позиций налево — вот сколько позиций, столько и инверсий мы убрали. А вот в сортировке выбором максимума так просто посчитать инверсии не получится, т.к., когда мы переставляем там элемент, мы не знаем — среди тех элементов, кого он "обогнал", сколько было больше его, а сколько меньше. (Конечно, это можно посчитать, но тогда проще уже честный подсчет инверсий проверкой всех пар сделать.)</p>
        
        <p>По тем же соображениям quicksort не получится адаптировать для подсчета инверсий: когда мы меняем местами два элемента, мы не знаем, сколько инверсий при этом пропадает, т.к. не знаем, какие именно элементы стоят посередине.</p>
        
        <p>А вот сортировку слиянием адаптировать можно. Может быть, это не так очевидно, но, когда мы берем элемент из первой половины (<code>a[i1]</code>), то мы не убираем ни одну инверсию, а когда мы берем элемент из второй половины (<code>a[i2]</code>), то мы убираем <code>o-i1+1</code> инверсию: он обгоняет все еще не взятые элементы первой половины, и при этом все эти элементы больше его. Поэтому получаем следующий код:</p>
        <pre>procedure sort(l,r:integer); // сортируем кусок массива от l до r включительно
        var i,i1,i2,o:integer;
        begin
        if l&gt;=r then exit; // если кусок короткий, то сортировать нечего
                           // это же — условие выхода из рекурсии
        o:=(l+r) div 2;
        // разбили на две половинки: (l..o) и (o+1..r)
        // отсортируем
        sort(l,o);
        sort(o+1,r);
        // сольем во временный массив
        i1:=l;
        i2:=o+1;
        for i:=l to r do 
            if (i1&lt;=o)and((i2&gt;r)or(a[i1]&lt;=a[i2])) then begin
                aa[i]:=a[i1];
                inc(i1);
            end else begin
                inversions:=inversions+o-i1+1; 
                aa[i]:=a[i2];
                inc(i2);
            end;
        // перенесем из временного обратно в основной массив
        for i:=l to r do
            a[i]:=aa[i];
        end;
        </pre>
        <p>Ответ — в переменной <code>inversions</code>. Обратите внимание, что в этом коде есть еще одно отличие от кода сортировки, приведенного выше, и поймите, почему это так.</p></div>
    """, {skipTree: true})

topic_16576 = () ->
    return topic("Логарифмические сортировки", "4А: Задачи на логарифмические сортировки", [
    ])


export default sorting = () ->
    return {
        topic: topic("Сортировки", "Задачи на сортировки", [
            label("Видеозаписи лекций ЛКШ по квадратичным сортировкам: <a href=\"https://sis.khashaev.ru/2013/august/c-prime/kBHwr_e_aAg/\">сортировка пузырьком</a>, <a href=\"https://sis.khashaev.ru/2013/august/c-prime/gZGwKXwjffg/\">выбором максимума</a>. К сожалению, теории по сортировкой вставками тут пока нет. Найдите в интернете или прослушайте на занятии."),
            label("Внимание! В задаче \"Библиотечный метод\" надо выводить очередную строку только если состояние массива при этой вставке изменилось."),
            module16475(),
            problem(230),
            problem(1436),
            problem(1411),
            problem(1099),
            problem(39),
            problem(1442),
            problem(766),
            problem(1418),
        ]),
        advancedProblems: [
            problem(767),
            problem(3142),
            problem(720),
            problem(1137),
            problem(111628),
            problem(1630),
            problem(111162),
            problem(111751),
        ]
    }