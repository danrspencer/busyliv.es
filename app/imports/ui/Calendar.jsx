import moment from 'moment';
import React, { Component, PropTypes } from 'react';
import { compose, groupBy, values, map, mapObjIndexed, reduce } from 'ramda';

const weekDays = [1,2,3,4,5,6,0];


// have colours for months, winter blue, etc...

const Day = React.createClass({
    render: function() {
        return <li>{this.props.day.date.date()}</li>;
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
        const firstDay = this.props.days[0].date;

        return (
            <div>
                <div>
                    Float me left with month name
                </div>
                <div>
                    <ul>
                        { weekDays.map(
                            (dayOfWeek) => <li> { moment().weekday(dayOfWeek).format('dd') } </li> )
                        }
                    </ul>

                    <ul>
                        {
                            weekDays.filter((dayOfWeek) => dayOfWeek < firstDay.weekday() - 1)
                                .map(() => <li>X</li>)
                        }
                        { this.props.days.map(
                            (day) => <Day key={day.date.format('YYYYMMDD')} day={day} /> ) }
                    </ul>

                </div>
            </div>
        );
    }
});