import React, { Component, PropTypes } from 'react';
import { compose, groupBy, keys, map, reduce } from 'ramda';

let Month = React.createClass({
    render: function() {
        return <ul>
            {map((day) => <Day key={day.date.format('DD')} day={day} />, this.props.month)}
        </ul>
    }
});

let Day = React.createClass({
    render: function() {
        return <li>{this.props.day.date.format('DD')}</li>;
    }
});

export default class Calendar extends Component {
    render() {
        const months = groupBy(day => day.date.month(), this.props.days);
        const monthKeys = keys(months);
        const sortedMonthsArray = map((key) => months[key], monthKeys);

        return (
            <div>
                { map((month, index) => <Month key={index} month={month} />, sortedMonthsArray) }
            </div>
        );
    }
}

Calendar.propTypes = {
    // This component gets the task to display through a React prop.
    // We can use propTypes to indicate it is required
    days: PropTypes.array.isRequired,
};