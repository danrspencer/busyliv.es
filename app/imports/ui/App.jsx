import React, { Component } from 'react';

import { generateCalendar, nlpMoment, uid } from '../func/utils.js';

import Events from '../api/events.js';
import Calendar from './Calendar.jsx';

import date from 'date.js';

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

        date(text);

        this.setState(endDate == null
            ? { end }
            : { end, endDate }
        );
    },

    createEvent() {
        const event = {
            uid: uid(),
            calendar: this.getCalendar()
        };

        Events.insert(event);

        console.log(event);
    },

    getCalendar() {
        return generateCalendar(this.state.startDate, this.state.endDate)
    },

    render() {
        return (
            <div className="container">
                <header>
                    <h1>busyliv.es</h1>
                </header>

                Event title <input type="text" value="" />
                <br /><br />

                Create event between
                <input type="text" value={this.state.start} onChange={this.onStartDateChange} />
                and
                <input type="text" value={this.state.end} onChange={this.onEndDateChange} />

                <br /><br /><br />

                <Calendar days={this.getCalendar()} />

                <button onClick={this.createEvent}>Create event!</button>
            </div>
        );
    }
});