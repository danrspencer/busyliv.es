/* @flow */

import moment from 'moment';
import { curry, map, times } from 'ramda';

const generateCalendar = (startDate: string, endDate: string) => {
    const incrementDay = curry((day, amount) => day.clone().add(amount, 'day'));
    const generateDayList = (startDay, length) => times(incrementDay(startDay), length);

    const start = moment(startDate);
    const end = moment(endDate);
    const days = end.diff(start, 'days') + 1;

    const dayList = generateDayList(start, days);

    return map((day) => ({ date: day }), dayList);
};

const uid = () => Math.random().toString(36).substr(2, 16);

export { generateCalendar, uid }