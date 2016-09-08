import moment from 'moment';
import React, { Component, PropTypes } from 'react';
import { apply, compose, groupBy, map, mapObjIndexed, reduce, values } from 'ramda';

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

    render() {
        const firstDay = moment(this.props.days[0].date);

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
                        { this.props.days.map((day) => compose(
                            (mo) => <Day key={mo.date.format('YYYYMMDD')} day={mo} />,
                            moment)
                        )}
                    </ul>

                </div>
            </div>
        );
    }
});