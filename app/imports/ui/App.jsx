import React, { Component } from 'react';

import { generateCalendar, nlpMoment } from '../func/date.js';

import Calendar from './Calendar.jsx';

export default React.createClass({
    getInitialState() {
        const start = "today";
        const end = "next month";

        return {
            start,
            end,
            startDate: nlpMoment(start),
            endDate: nlpMoment(end)
        };
    },

    onStartDateChange(event) {
        const start = event.target.value;
        const startDate = nlpMoment(start);

        this.setState(startDate == null
            ? { start }
            : { start, startDate }
        );
    },

    onEndDateChange(event) {
        const end = event.target.value;
        const endDate = nlpMoment(end);

        this.setState(endDate == null
            ? { end }
            : { end, endDate }
        );
    },

    render() {
        return (
            <div className="container">
                <header>
                    <h1>busyliv.es</h1>
                </header>

                Create event between
                <input type="text" value={this.state.start} onChange={this.onStartDateChange} />
                and
                <input type="text" value={this.state.end} onChange={this.onEndDateChange} />

                <br /><br /><br />

                <Calendar days={generateCalendar(this.state.startDate, this.state.endDate)} />
            </div>
        );
    }
});