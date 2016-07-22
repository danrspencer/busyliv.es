import React, { Component, PropTypes } from 'react';
import { compose, groupBy, values, map, mapObjIndexed, reduce } from 'ramda';

const Month = React.createClass({
    render: function() {
        return <ul>
            {map((day) => <Day key={day.date.format('DD')} day={day} />, this.props.month)}
        </ul>
    }
});

const Day = React.createClass({
    render: function() {
        return <li>{this.props.day.date.format('DD')}</li>;
    }
});

export default React.createClass({

    propTypes: {
        days: PropTypes.array.isRequired
    },

    renderMonths: compose(
        values,
        mapObjIndexed((month, monthNum) => <Month key={monthNum} month={month} />),
        groupBy(day => day.date.month())
    ),

    render() {
        return (
            <div>
                { this.renderMonths(this.props.days) }
            </div>
        );
    }
});