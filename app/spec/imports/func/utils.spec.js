import moment from 'moment';
import { times } from 'ramda';

import { expect } from 'meteor/practicalmeteor:chai';

import { generateCalendar, nlpMoment } from '../../../imports/func/utils.js'

describe('generateCalendar', () => {
    it('returns the length of the diff between days in days', () => {
        const result = generateCalendar('2010/01/01', '2010/01/05');

        expect(result.length).to.equal(5);
    });

    it('returns the first element as the given start date', () => {
        const startDate = '2010/05/01';
        const endDate = '2010/06/01';
        const result = generateCalendar(startDate, endDate);

        const actual = result[0].date;
        const expected = new Date(startDate);

        expect(actual).to.deep.equal(expected);
    });

    it('returns the last element as the given end date', () => {
        const startDate = '2010/05/01';
        const endDate = '2010/06/01';
        const result = generateCalendar(startDate, endDate);

        const actual = result[result.length - 1].date;
        const expected = new Date(endDate);

        expect(actual).to.deep.equal(expected);
    });

    it('returns a list of contiguous days', () => {
        const startDate = '2010/05/01';
        const endDate = '2010/06/01';
        const result = generateCalendar(startDate, endDate);

        result.forEach((item, index) => {
            const actual = item.date;
            const expected = new Date(startDate);
            expected.setDate(expected.getDate() + index);

            expect(actual).to.deep.equal(expected);
        });
    });
});