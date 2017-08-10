React = require('react')
import fetch from 'isomorphic-fetch'

import { Grid } from 'react-bootstrap'
import Dashboard from '../components/Dashboard'
import callApi from '../lib/callApi'

class DashboardPage extends React.Component 
    constructor: (props) ->
        super(props)
        @state = props.data || window.__INITIAL_STATE__ || {}
        
    render:  () ->
        return 
            <Grid fluid>
                {`<Dashboard {...this.state}/>`}
            </Grid>
            
    componentDidMount: ->
        data = await DashboardPage.loadData(@props.match)
        @setState(data)
        
    @loadData: (match) ->
        callApi 'dashboard'

export default DashboardPage 