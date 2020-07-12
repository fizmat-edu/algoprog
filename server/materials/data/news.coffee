import news from "../lib/news"
import newsItem from "../lib/newsItem"

export default allNews = () ->
    return news([
        newsItem("Переход на новый учебный год и деактивация аккаунтов", """
            В связи с переходом на новый учебный год я деактивировал почти все аккаунты. Если вы планируете продолжать заниматься, напишите мне, я активирую ваш аккаунт. Если вы школьник, 
            то заодно напишите мне, в какой класс и какой школы вы перешли.
        """),
        newsItem("Стажировка на алгопроге", """
            Как и в прошлом году, этим летом вы можете «постажироваться» на алгопроге, дописав алгопрогу новую функциональность. <a href="/material/module-20927_39" onclick="window.goto('/material/module-20927_39')();return false;">Подробнее</a>
        """),
        newsItem("Про очные занятия в этом учебном году и летом", """
            В этом учебном году очных занятий больше не будет. Возможно, будет несколько занятий летом для желающих, следите за объявлениями на сайте. Очные занятия в следующем учебном году начнутся в середине сентября (если не продлят карантин), следите за объявлениями.
        """),
        newsItem("Опрос про алгопрог (обновлен!)", """
            Ответьте, пожалуйста, <a href="https://docs.google.com/forms/d/e/1FAIpQLSdDXTZ1yMHp_yk3Di5ie4BcI9HXKtnlJ8iyp9iupdX4fezqag/viewform?usp=sf_link">на несколько вопросов</a>. Тем, кто уже отвечал — я там добавил несколько вопросов, можете ответить еще раз.
        """),
    ])
