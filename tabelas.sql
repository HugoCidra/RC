CREATE TABLE utilizador (
	user_id	 INTEGER,
	nome		 VARCHAR(512) NOT NULL,
	morada	 VARCHAR(512) NOT NULL,
	email	 VARCHAR(512) NOT NULL,
	palavra_passe VARCHAR(512) NOT NULL,
	PRIMARY KEY(user_id)
);

CREATE TABLE administrador (
	utilizador_user_id INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE artista (
	nome_artistico			 VARCHAR(512) NOT NULL,
	administrador_utilizador_user_id INTEGER NOT NULL,
	utilizador_user_id		 INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE consumidor (
    cc INTEGER NOT NULL,
    tipo VARCHAR(512) NOT NULL,
    utilizador_user_id		 INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE consumidor_top10 (
	cc				 INTEGER NOT NULL,
	tipo				 VARCHAR(512) NOT NULL,
	top10_streams			 INTEGER NOT NULL,
	musica_song_id			 INTEGER NOT NULL,
	musica_artista_utilizador_user_id INTEGER NOT NULL,
	utilizador_user_id		 INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE subscricao_pre_pago_historicosubs (
	sub_id					 INTEGER,
	duracao					 TIMESTAMP NOT NULL,
	preco					 FLOAT(8) NOT NULL,
	pre_pago_historicosubs_pre_paid_id		 INTEGER NOT NULL,
	pre_pago_historicosubs_limit_date		 DATE NOT NULL,
	pre_pago_historicosubs_valor		 INTEGER NOT NULL,
	pre_pago_historicosubs_preco		 INTEGER NOT NULL,
	pre_pago_historicosubs_historicosubs_user_id INTEGER NOT NULL,
	pre_pago_historicosubs_historicosubs_tipo	 BOOL NOT NULL,
	pre_pago_historicosubs_historicosubs_dia	 DATE NOT NULL,
	administrador_utilizador_user_id		 INTEGER NOT NULL,
	PRIMARY KEY(sub_id)
);

CREATE TABLE playlist (
	playlist_id			 INTEGER,
	tipo				 VARCHAR(512) NOT NULL,
	musicas				 VARCHAR(512) NOT NULL,
	consumidor_top10_utilizador_user_id INTEGER NOT NULL,
	PRIMARY KEY(playlist_id)
);

CREATE TABLE comentario (
	comment_id				 INTEGER,
	conteudo				 TEXT NOT NULL,
	comentario_comment_id		 INTEGER NOT NULL,
	musica_song_id			 INTEGER NOT NULL,
	musica_artista_utilizador_user_id	 INTEGER NOT NULL,
	consumidor_top10_utilizador_user_id INTEGER NOT NULL,
	PRIMARY KEY(comment_id)
);

CREATE TABLE musica (
	song_id			 INTEGER,
	titulo			 VARCHAR(512) NOT NULL,
	duracao			 TIMESTAMP NOT NULL,
	ismn			 INTEGER NOT NULL,
	lable			 VARCHAR(512) NOT NULL,
	genero			 VARCHAR(512) NOT NULL,
	data_lancamento		 DATE NOT NULL,
	info_artistas		 TEXT,
	artista_utilizador_user_id INTEGER,
	PRIMARY KEY(song_id,artista_utilizador_user_id)
);

CREATE TABLE album (
	album_id			 INTEGER,
	nome			 INTEGER NOT NULL,
	artista_utilizador_user_id INTEGER,
	PRIMARY KEY(album_id,artista_utilizador_user_id)
);

CREATE TABLE ordem (
	pos				 INTEGER NOT NULL,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	album_album_id			 INTEGER,
	album_artista_utilizador_user_id	 INTEGER,
	PRIMARY KEY(musica_song_id,musica_artista_utilizador_user_id,album_album_id,album_artista_utilizador_user_id)
);

CREATE TABLE consumidor_top10_musica (
	consumidor_top10_utilizador_user_id INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id	 INTEGER,
	PRIMARY KEY(consumidor_top10_utilizador_user_id,musica_song_id,musica_artista_utilizador_user_id)
);

CREATE TABLE playlist_musica (
	playlist_playlist_id		 INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	PRIMARY KEY(playlist_playlist_id,musica_song_id,musica_artista_utilizador_user_id)
);

ALTER TABLE administrador ADD CONSTRAINT administrador_fk1 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE artista ADD UNIQUE (nome_artistico);
ALTER TABLE artista ADD CONSTRAINT artista_fk1 FOREIGN KEY (administrador_utilizador_user_id) REFERENCES administrador(utilizador_user_id);
ALTER TABLE artista ADD CONSTRAINT artista_fk2 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE consumidor ADD CONSTRAINT consumidor_fk1 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE consumidor_top10 ADD CONSTRAINT consumidor_top10_fk1 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE consumidor_top10 ADD CONSTRAINT consumidor_top10_fk2 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE subscricao_pre_pago_historicosubs ADD UNIQUE (pre_pago_historicosubs_pre_paid_id, pre_pago_historicosubs_historicosubs_user_id);
ALTER TABLE subscricao_pre_pago_historicosubs ADD CONSTRAINT subscricao_pre_pago_historicosubs_fk1 FOREIGN KEY (administrador_utilizador_user_id) REFERENCES administrador(utilizador_user_id);
ALTER TABLE playlist ADD CONSTRAINT playlist_fk1 FOREIGN KEY (consumidor_top10_utilizador_user_id) REFERENCES consumidor_top10(utilizador_user_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk1 FOREIGN KEY (comentario_comment_id) REFERENCES comentario(comment_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk3 FOREIGN KEY (consumidor_top10_utilizador_user_id) REFERENCES consumidor_top10(utilizador_user_id);
ALTER TABLE musica ADD UNIQUE (ismn);
ALTER TABLE musica ADD CONSTRAINT musica_fk1 FOREIGN KEY (artista_utilizador_user_id) REFERENCES artista(utilizador_user_id);
ALTER TABLE album ADD CONSTRAINT album_fk1 FOREIGN KEY (artista_utilizador_user_id) REFERENCES artista(utilizador_user_id);
ALTER TABLE ordem ADD CONSTRAINT ordem_fk1 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE ordem ADD CONSTRAINT ordem_fk2 FOREIGN KEY (album_album_id, album_artista_utilizador_user_id) REFERENCES album(album_id, artista_utilizador_user_id);
ALTER TABLE consumidor_top10_musica ADD CONSTRAINT consumidor_top10_musica_fk1 FOREIGN KEY (consumidor_top10_utilizador_user_id) REFERENCES consumidor_top10(utilizador_user_id);
ALTER TABLE consumidor_top10_musica ADD CONSTRAINT consumidor_top10_musica_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE playlist_musica ADD CONSTRAINT playlist_musica_fk1 FOREIGN KEY (playlist_playlist_id) REFERENCES playlist(playlist_id);
ALTER TABLE playlist_musica ADD CONSTRAINT playlist_musica_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);