CLASS zcl_itab_nesting DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES: BEGIN OF artists_type,
             artist_id   TYPE string,
             artist_name TYPE string,
           END OF artists_type.
    TYPES artists TYPE STANDARD TABLE OF artists_type WITH KEY artist_id.
    TYPES: BEGIN OF albums_type,
             artist_id  TYPE string,
             album_id   TYPE string,
             album_name TYPE string,
           END OF albums_type.
    TYPES albums TYPE STANDARD TABLE OF albums_type WITH KEY artist_id album_id.
    TYPES: BEGIN OF songs_type,
             artist_id TYPE string,
             album_id  TYPE string,
             song_id   TYPE string,
             song_name TYPE string,
           END OF songs_type.
    TYPES songs TYPE STANDARD TABLE OF songs_type WITH KEY artist_id album_id song_id.


    TYPES: BEGIN OF song_nested_type,
             song_id   TYPE string,
             song_name TYPE string,
           END OF song_nested_type.
    TYPES: BEGIN OF album_song_nested_type,
             album_id   TYPE string,
             album_name TYPE string,
             songs      TYPE STANDARD TABLE OF song_nested_type WITH KEY song_id,
           END OF album_song_nested_type.
    TYPES: BEGIN OF artist_album_nested_type,
             artist_id   TYPE string,
             artist_name TYPE string,
             albums      TYPE STANDARD TABLE OF album_song_nested_type WITH KEY album_id,
           END OF artist_album_nested_type.
    TYPES nested_data TYPE STANDARD TABLE OF artist_album_nested_type WITH KEY artist_id.

    METHODS perform_nesting
      IMPORTING
        artists            TYPE artists
        albums             TYPE albums
        songs              TYPE songs
      RETURNING
        VALUE(nested_data) TYPE nested_data.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_itab_nesting IMPLEMENTATION.

  METHOD perform_nesting.

    DATA: lv_index  TYPE sy-tabix,
          lv_index2 TYPE sy-tabix.

    DATA: wa_nested_data       TYPE artist_album_nested_type,
          wa_album_song_nested TYPE album_song_nested_type,
          wa_song_nested_type  TYPE song_nested_type.

    CLEAR: lv_index,
           lv_index2,
           wa_nested_data,
           wa_album_song_nested,
           wa_song_nested_type.

    SORT artists
      BY artist_id ASCENDING.

    SORT albums
      BY artist_id
         album_id ASCENDING.

    SORT songs
      BY artist_id
         album_id
         song_id ASCENDING.

    LOOP AT artists ASSIGNING FIELD-SYMBOL(<lfs_artists>).

      CLEAR: wa_nested_data.
      wa_nested_data-artist_id   = <lfs_artists>-artist_id.
      wa_nested_data-artist_name = <lfs_artists>-artist_name.

      READ TABLE albums TRANSPORTING NO FIELDS
        WITH KEY artist_id = <lfs_artists>-artist_id BINARY SEARCH.
      IF sy-subrc = 0.
        lv_index = sy-tabix.

        LOOP AT albums ASSIGNING FIELD-SYMBOL(<lfs_albums>) FROM lv_index.

          IF <lfs_albums>-artist_id <> <lfs_artists>-artist_id.
            EXIT.
          ENDIF.

          CLEAR:
          wa_album_song_nested.

          wa_album_song_nested-album_id   = <lfs_albums>-album_id.
          wa_album_song_nested-album_name = <lfs_albums>-album_name.

          READ TABLE songs TRANSPORTING NO FIELDS
            WITH KEY artist_id = <lfs_artists>-artist_id
                     album_id  = <lfs_albums>-album_id BINARY SEARCH.
          IF sy-subrc = 0.
            lv_index2 = sy-tabix.

            LOOP AT songs ASSIGNING FIELD-SYMBOL(<lfs_songs>) FROM lv_index2.

              IF <lfs_songs>-artist_id <> <lfs_artists>-artist_id OR
                 <lfs_songs>-album_id  <> <lfs_albums>-album_id.
                EXIT.
              ENDIF.

              CLEAR: wa_song_nested_type.
              wa_song_nested_type-song_id   = <lfs_songs>-song_id.
              wa_song_nested_type-song_name = <lfs_songs>-song_name.

              APPEND wa_song_nested_type TO wa_album_song_nested-songs.
            
            ENDLOOP.
          ENDIF.

          APPEND wa_album_song_nested TO wa_nested_data-albums.
        
        ENDLOOP.
      ENDIF.

      APPEND wa_nested_data TO nested_data.

    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
