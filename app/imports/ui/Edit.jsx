import React, { Component } from 'react';

import { generateCalendar, nlpMoment, uid } from '../func/utils.js';

import Events from '../api/events.js';
import Calendar from './Calendar.jsx';


export default React.createClass({
    getInitialState() {
        return {
            start: "2016-01-01",
            end: "2016-01-30",
            title: ""
        };
    },

    render() {
        return (
            <div className="container">
                <header>
                    <h1>busyliv.es</h1>
                </header>
                <Calendar days={generateCalendar(this.state.start, this.state.end)} />
            </div>
        );
    }
});