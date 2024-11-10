import fs from 'fs';
import path from 'path';

const commentsFilePath = path.resolve(process.cwd(), 'comments.json');

const readComments = () => {
  try {
    return JSON.parse(fs.readFileSync(commentsFilePath, 'utf-8'));
  } catch {
    return {};
  }
};

const writeComments = (data) => {
  fs.writeFileSync(commentsFilePath, JSON.stringify(data, null, 2));
};

export default function handler(req, res) {
  const { chartType, task, context, name, comment } = req.body;

  if (req.method === 'POST') {
    if (!name || !comment) {
      return res.status(400).json({ error: 'Name and comment are required' });
    }

    const comments = readComments();
    const itemKey = `${chartType}-${task}-${context}`;
    if (!comments[itemKey]) {
      comments[itemKey] = [];
    }
    comments[itemKey].push({ name, comment, timestamp: new Date().toISOString() });
    writeComments(comments);

    res.status(200).json({ success: true });
  } else if (req.method === 'GET') {
    const comments = readComments();
    res.status(200).json(comments);
  } else {
    res.status(405).json({ error: 'Method not allowed' });
  }
}
