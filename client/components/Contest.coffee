React = require('react')
import { Link } from 'react-router-dom'
import { ListGroup, ListGroupItem } from 'react-bootstrap'
import { withRouter } from 'react-router'

goToProblem = (m, history) ->
    () ->
        history.push("/problem/" + m)

Contest = (props) ->
    <ListGroup>
        {
        res = []
        a = (el) -> res.push(el)
        for m in props.contest.materials
            #a <Link to={"/problem/" + m._id} key={m._id}>Problem {m._id}</Link>
            a <ListGroupItem key={m} onClick={goToProblem(m, props.history)}>Problem {m}</ListGroupItem>
        res}
    </ListGroup>

export default withRouter(Contest)