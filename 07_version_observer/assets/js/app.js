import { Elm } from '../src/Main.elm';
import socket from './socket';
import '../css/app.css';
import 'phoenix_html';

const { appVersion } = window;

const app = Elm.Main.init({ flags: { appVersion } });

const channel = socket.channel('version', {});

channel.join()
  .receive('ok', (resp) => {
    console.log('Joined successfully', resp);

    channel.on('new_version', ({ version }) => {
      console.log('new version received', version);

      app.ports.newVersion.send(version);
    });
  })
  .receive('error', (resp) => { console.log('Unable to join', resp); });
