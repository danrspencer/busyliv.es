import moment from 'moment';
import { times } from 'ramda';

import { expect } from 'meteor/practicalmeteor:chai';

import { generateCalendar, nlpMoment } from '../../../imports/func/utils.js'

describe('generateCalendar', () => {
    it('returns the length of the diff between days in days', () => {
        const result = generateCalendar({ year: 2000, month: 1, day: 1 }, { year: 2000, month: 1, day: 5 });

        expect(result.length).to.equal(5);
    });

    it('returns the first element as the given date', () => {
        const startDate = { year: 2010, month: 5, day: 1 };
        const result = generateCalendar(startDate, { year: 2010, month: 6, day: 1 });

        const actual = result[0].date.format('DD-MM-YYYY');
        const expected = moment(startDate).format('DD-MM-YYYY');

        expect(actual).to.equal(expected);
    });

    it('returns the last element as the given end date', () => {
        const endDate = { year: 2010, month: 5, day: 30 };
        const result = generateCalendar({ year: 2010, month: 5, day: 1 }, endDate);

        const actual = result[result.length - 1].date.format('DD-MM-YYYY');
        const expected = moment(endDate).format('DD-MM-YYYY');

        expect(actual).to.equal(expected);
    });

    it('returns a list of contiguous days', () => {
        const startDate = { year: 2000, month: 1, day: 1 };
        const result = generateCalendar(startDate, { year: 2000, month: 1, day: 6 });

        result.forEach((item, index) => {
            const actual = item.date.format('DD-MM-YYYY');
            const expected = moment(startDate).add(index, 'day').format('DD-MM-YYYY');

            expect(actual).to.equal(expected);
        });
    });
});