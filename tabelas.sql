CREATE TABLE utilizador (
	user_id	 INTEGER,
	nome		 VARCHAR(512) NOT NULL,
	morada	 VARCHAR(512) NOT NULL,
	email	 VARCHAR(512) NOT NULL,
	palavra_passe VARCHAR(512) NOT NULL,
	PRIMARY KEY(user_id)
);

CREATE TABLE admin (
	nome		 VARCHAR(512) NOT NULL,
	utilizador_user_id INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE artista (
	nome_artistico		 VARCHAR(512) NOT NULL,
	admin_utilizador_user_id INTEGER,
	utilizador_user_id	 INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE consumidor (
	cc		 INTEGER NOT NULL,
	tipo		 VARCHAR(512) NOT NULL,
	utilizador_user_id INTEGER,
	PRIMARY KEY(utilizador_user_id)
);

CREATE TABLE subscricao (
	sub_id	 INTEGER,
	duracao TIMESTAMP NOT NULL,
	preco	 FLOAT(8) NOT NULL,
	PRIMARY KEY(sub_id)
);

CREATE TABLE historicosubs (
	hist_id			 INTEGER,
	user_id			 INTEGER NOT NULL,
	tipo			 BOOL NOT NULL,
	dia			 DATE NOT NULL,
	cartao_pre_pago_pre_paid_id INTEGER,
	subscricao_sub_id		 INTEGER,
	PRIMARY KEY(hist_id,cartao_pre_pago_pre_paid_id,subscricao_sub_id)
);

CREATE TABLE playlist (
	playlist_id			 INTEGER,
	nome				 VARCHAR(512) NOT NULL,
	visibilidade			 VARCHAR(512) NOT NULL,
	consumidor_utilizador_user_id INTEGER NOT NULL,
	PRIMARY KEY(playlist_id)
);

CREATE TABLE comentario (
	comment_id			 INTEGER,
	conteudo				 TEXT NOT NULL,
	comentario_comment_id		 INTEGER NOT NULL,
	musica_song_id			 INTEGER NOT NULL,
	musica_artista_utilizador_user_id INTEGER NOT NULL,
	consumidor_utilizador_user_id	 INTEGER NOT NULL,
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

CREATE TABLE cartao_pre_pago (
	pre_paid_id		 INTEGER,
	limit_date		 DATE NOT NULL,
	valor			 INTEGER NOT NULL,
	preco			 INTEGER NOT NULL,
	admin_utilizador_user_id INTEGER NOT NULL,
	PRIMARY KEY(pre_paid_id)
);

CREATE TABLE top10 (
	streams				 INTEGER NOT NULL,
	consumidor_utilizador_user_id	 INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	PRIMARY KEY(consumidor_utilizador_user_id,musica_song_id,musica_artista_utilizador_user_id)
);

CREATE TABLE ordem (
	pos				 INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	album_album_id			 INTEGER,
	album_artista_utilizador_user_id	 INTEGER,
	PRIMARY KEY(pos,musica_song_id,musica_artista_utilizador_user_id,album_album_id,album_artista_utilizador_user_id)
);

CREATE TABLE subscricao_cartao_pre_pago (
	subscricao_sub_id		 INTEGER,
	cartao_pre_pago_pre_paid_id INTEGER,
	PRIMARY KEY(subscricao_sub_id,cartao_pre_pago_pre_paid_id)
);

CREATE TABLE subscricao_consumidor (
	subscricao_sub_id		 INTEGER,
	consumidor_utilizador_user_id INTEGER,
	PRIMARY KEY(subscricao_sub_id,consumidor_utilizador_user_id)
);

CREATE TABLE cartao_pre_pago_consumidor (
	cartao_pre_pago_pre_paid_id	 INTEGER,
	consumidor_utilizador_user_id INTEGER NOT NULL,
	PRIMARY KEY(cartao_pre_pago_pre_paid_id)
);

CREATE TABLE consumidor_musica (
	consumidor_utilizador_user_id	 INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	PRIMARY KEY(consumidor_utilizador_user_id,musica_song_id,musica_artista_utilizador_user_id)
);

CREATE TABLE playlist_musica (
	playlist_playlist_id		 INTEGER,
	musica_song_id			 INTEGER,
	musica_artista_utilizador_user_id INTEGER,
	PRIMARY KEY(playlist_playlist_id,musica_song_id,musica_artista_utilizador_user_id)
);

ALTER TABLE admin ADD CONSTRAINT admin_fk1 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE artista ADD UNIQUE (nome_artistico);
ALTER TABLE artista ADD CONSTRAINT artista_fk1 FOREIGN KEY (admin_utilizador_user_id) REFERENCES admin(utilizador_user_id);
ALTER TABLE artista ADD CONSTRAINT artista_fk2 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE consumidor ADD CONSTRAINT consumidor_fk1 FOREIGN KEY (utilizador_user_id) REFERENCES utilizador(user_id);
ALTER TABLE historicosubs ADD UNIQUE (user_id);
ALTER TABLE historicosubs ADD CONSTRAINT historicosubs_fk1 FOREIGN KEY (cartao_pre_pago_pre_paid_id) REFERENCES cartao_pre_pago(pre_paid_id);
ALTER TABLE historicosubs ADD CONSTRAINT historicosubs_fk2 FOREIGN KEY (subscricao_sub_id) REFERENCES subscricao(sub_id);
ALTER TABLE playlist ADD CONSTRAINT playlist_fk1 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk1 FOREIGN KEY (comentario_comment_id) REFERENCES comentario(comment_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE comentario ADD CONSTRAINT comentario_fk3 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE musica ADD UNIQUE (ismn);
ALTER TABLE musica ADD CONSTRAINT musica_fk1 FOREIGN KEY (artista_utilizador_user_id) REFERENCES artista(utilizador_user_id);
ALTER TABLE album ADD CONSTRAINT album_fk1 FOREIGN KEY (artista_utilizador_user_id) REFERENCES artista(utilizador_user_id);
ALTER TABLE cartao_pre_pago ADD CONSTRAINT cartao_pre_pago_fk1 FOREIGN KEY (admin_utilizador_user_id) REFERENCES admin(utilizador_user_id);
ALTER TABLE top10 ADD CONSTRAINT top10_fk1 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE top10 ADD CONSTRAINT top10_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE ordem ADD CONSTRAINT ordem_fk1 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE ordem ADD CONSTRAINT ordem_fk2 FOREIGN KEY (album_album_id, album_artista_utilizador_user_id) REFERENCES album(album_id, artista_utilizador_user_id);
ALTER TABLE subscricao_cartao_pre_pago ADD CONSTRAINT subscricao_cartao_pre_pago_fk1 FOREIGN KEY (subscricao_sub_id) REFERENCES subscricao(sub_id);
ALTER TABLE subscricao_cartao_pre_pago ADD CONSTRAINT subscricao_cartao_pre_pago_fk2 FOREIGN KEY (cartao_pre_pago_pre_paid_id) REFERENCES cartao_pre_pago(pre_paid_id);
ALTER TABLE subscricao_consumidor ADD CONSTRAINT subscricao_consumidor_fk1 FOREIGN KEY (subscricao_sub_id) REFERENCES subscricao(sub_id);
ALTER TABLE subscricao_consumidor ADD CONSTRAINT subscricao_consumidor_fk2 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE cartao_pre_pago_consumidor ADD CONSTRAINT cartao_pre_pago_consumidor_fk1 FOREIGN KEY (cartao_pre_pago_pre_paid_id) REFERENCES cartao_pre_pago(pre_paid_id);
ALTER TABLE cartao_pre_pago_consumidor ADD CONSTRAINT cartao_pre_pago_consumidor_fk2 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE consumidor_musica ADD CONSTRAINT consumidor_musica_fk1 FOREIGN KEY (consumidor_utilizador_user_id) REFERENCES consumidor(utilizador_user_id);
ALTER TABLE consumidor_musica ADD CONSTRAINT consumidor_musica_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);
ALTER TABLE playlist_musica ADD CONSTRAINT playlist_musica_fk1 FOREIGN KEY (playlist_playlist_id) REFERENCES playlist(playlist_id);
ALTER TABLE playlist_musica ADD CONSTRAINT playlist_musica_fk2 FOREIGN KEY (musica_song_id, musica_artista_utilizador_user_id) REFERENCES musica(song_id, artista_utilizador_user_id);