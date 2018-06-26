var ObjectID = require('mongodb').ObjectID;

module.exports = function(app, db) {

  app.get('/events/', (req, res) => {
    db.collection('events').find({}).toArray(function(err, result) {
      if (err) {
        res.send({'error':'An error has occurred'});
      } else {
        res.send(result);
      } 
    });
  });
  
app.post('/events', (req, res) => {
    const event = { title: req.body.title, description: req.body.description, startTime: parseFloat(req.body.startTime), endTime: parseFloat(req.body.endTime), day: parseInt(req.body.day) };
    db.collection('events').insert(event, (err, result) => {
      if (err) { 
        res.send({ 'error': 'An error has occurred' }); 
      } else {
        res.send(result.ops[0]);
      }
    });
  });

  app.delete('/events/:id', (req, res) => {
    const id = req.params.id;
    const details = { '_id': new ObjectID(id) };
    db.collection('events').remove(details, (err, item) => {
      if (err) {
        res.send({'error':'An error has occurred'});
      } else {
        res.send('Event ' + id + ' deleted!');
      } 
    });
  });

  app.put('/events/:id', (req, res) => {
    const id = req.params.id;
    const details = { '_id': new ObjectID(id) };
    const event = { title: req.body.title, description: req.body.description, startTime: parseFloat(req.body.startTime), endTime: parseFloat(req.body.endTime), day: parseInt(req.body.day) };
    db.collection('events').update(details, event, (err, result) => {
      if (err) {
          res.send({'error':'An error has occurred'});
      } else {
          res.send(event);
      } 
    });
  });
};