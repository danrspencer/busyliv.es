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

    onStartDateChange(event) {
        this.setState({ start: event.target.value });
    },

    onEndDateChange(event) {
        this.setState({ end: event.target.value });
    },

    createEvent() {
        const event = {
            uid: uid(8),
            title: this.state.title,
            calendar: generateCalendar(this.state.start, this.state.end)
        };

        console.log(event);

        Events.insert(event);

        FlowRouter.go('/' + event.uid);
    },

    render() {
        return (
            <div className="container">
                <header>
                    <h1>busyliv.es</h1>
                </header>

                <input type="text" value={this.state.title} placeholder="Event Name" />
                between
                <input type="date" value={this.state.start} onChange={this.onStartDateChange} />
                and
                <input type="date" value={this.state.end} onChange={this.onEndDateChange} />

                <br /><br />

                <button onClick={this.createEvent}>Create event!</button>

                <br /><br />

                <Calendar days={generateCalendar(this.state.start, this.state.end)} />
            </div>
        );
    }
});