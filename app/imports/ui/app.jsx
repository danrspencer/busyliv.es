import React, { Component } from 'react';
import Moment from 'moment';

import Month from './month.jsx';

let HeaderItem = React.createClass({
    render: function() {
        return <li>{this.props.text}</li>
    }
});

export default class App extends Component {

    getDays() {
        const now = Moment();
        const days = [];

        for (let n = 0; n <= 50; n++) {
            days.push({
                date: now.clone().add(n, 'day')
            });
        }

        return days;
    }
    
    renderHeader() {
        return Array.from({length: 31}, (v, k) => k+1)
                    .map(day => <HeaderItem key={day} text={day} />);
    }

    render() {
        return (
            <div className="container">
                <header>
                    <h1>busyliv.es</h1>
                </header>

                
                <ul>
                    {this.renderHeader()}
                </ul>

                <Month days={this.getDays()} />

            </div>
        );
    }
}