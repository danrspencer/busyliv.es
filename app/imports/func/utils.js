import moment from 'moment';
import { curry, map, times } from 'ramda';

const generateCalendar = (startDate: string, endDate: string) => {
    const start = moment(startDate);
    const end = moment(endDate);
    const days = end.diff(start, 'days') + 1;

    const dayList = [];

    for (let n = 0; n < days; n++) {
        dayList.push(start.clone().add(n, 'day'));
    }

    return dayList.map((day) => ({ date: day.toDate() }));
};

const uid = (length) => Math.random().toString(36).substr(2, length);

export { generateCalendar, uid }