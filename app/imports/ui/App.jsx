import React, { Component } from 'react';

import { generateCalendar, nlpMoment, uid } from '../func/utils.js';

import Events from '../api/events.js';
import Calendar from './Calendar.jsx';


export default React.createClass({
    getInitialState() {
        const start = "1990-01-01";
        const end = "1990-01-30";

        return {
            start,
            end
        };
    },

    onStartDateChange(event) {
        const start = event.target.value;

        this.setState({ start });
    },

    onEndDateChange(event) {
        const end = event.target.value;

        this.setState({ end });
    },

    createEvent() {
        const event = {
            uid: uid(),
            calendar: this.getCalendar()
        };

        FlowRouter.go(event.uid);
    },

    getCalendar() {
        return generateCalendar(this.state.start, this.state.end)
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
                <input type="date" value={this.state.start} onChange={this.onStartDateChange} />
                and
                <input type="date" value={this.state.end} onChange={this.onEndDateChange} />

                <br /><br /><br />

                <Calendar days={this.getCalendar()} />

                <button onClick={this.createEvent}>Create event!</button>
            </div>
        );
    }
});