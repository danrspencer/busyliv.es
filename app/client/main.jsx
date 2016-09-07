import React from 'react';
import { Meteor } from 'meteor/meteor';
import { render } from 'react-dom';

import Create from '../imports/ui/Create.jsx';
import Edit from '../imports/ui/Edit.jsx';

FlowRouter.route('/', {
    name: 'root',
    action() {
        ReactLayout.render(Create);
    }
});

FlowRouter.route('/:eventHash', {
    name: 'event',
    action(params) {
        ReactLayout.render(Edit);
    }
});