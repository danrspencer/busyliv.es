import moment from 'moment';
import date from 'date.js';

import { curry, map, times } from 'ramda';

const incrementDay = curry((day, amount) => day.clone().add(amount, 'day'));
const generateDayList = (startDay, length) => times(incrementDay(startDay), length);

const generateCalendar = (startDate, endDate) => {
    const start = moment(startDate);
    const end = moment(endDate);
    const days = end.diff(start, 'days') + 1;

    const dayList = generateDayList(start, days);

    return map((day) => ({ date: day }), dayList);
};

const nlpMoment = (text) => {
    const parsedDate = date(text);

    return moment(parsedDate);
};

export { generateCalendar, nlpMoment }