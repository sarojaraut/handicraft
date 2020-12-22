DECLARE
    l_context         apex_exec.t_context; 
    l_print_config    apex_data_export.t_print_config;
    l_export          apex_data_export.t_export;
BEGIN
    l_context := apex_exec.open_query_context(
        p_location    => apex_exec.c_location_local_db,
        p_sql_query   => 'select * from emp' );

    l_print_config := apex_data_export.get_print_config(
        p_orientation     => apex_data_export.c_orientation_portrait,
        p_border_width    => 2 );

    l_export := apex_data_export.export (
        p_context         => l_context,
        p_print_config    => l_print_config,
        p_format          => apex_data_export.c_format_pdf );

    apex_exec.close( l_context );

    apex_data_export.download( p_export => l_export );

EXCEPTION
    when others THEN
        apex_exec.close( l_context );
        raise;
END;

FUNCTION GET_PRINT_CONFIG(
    p_units                       IN t_unit         DEFAULT c_unit_inches,
    p_paper_size                  IN t_size         DEFAULT c_size_letter,
    p_width_units                 IN t_width_unit   DEFAULT c_width_unit_percentage,
    p_width                       IN NUMBER         DEFAULT 11,
    p_height                      IN NUMBER         DEFAULT 8.5,
    p_orientation                 IN t_orientation  DEFAULT c_orientation_landscape,
    --
    p_page_header                 IN VARCHAR2       DEFAULT NULL,
    p_page_header_font_color      IN t_color        DEFAULT '#000000',
    p_page_header_font_family     IN t_font_family  DEFAULT c_font_family_helvetica,
    p_page_header_font_weight     IN t_font_weight  DEFAULT c_font_weight_normal,
    p_page_header_font_size       IN NUMBER         DEFAULT 12,
    p_page_header_alignment       IN t_alignment    DEFAULT c_align_center,
    --
    p_page_footer                 IN VARCHAR2       DEFAULT NULL,
    p_page_footer_font_color      IN t_color        DEFAULT '#000000',
    p_page_footer_font_family     IN t_font_family  DEFAULT c_font_family_helvetica,
    p_page_footer_font_weight     IN t_font_weight  DEFAULT c_font_weight_normal,
    p_page_footer_font_size       IN NUMBER         DEFAULT 12,
    p_page_footer_alignment       IN t_alignment    DEFAULT c_align_center,
    --
    p_header_bg_color             IN t_color        DEFAULT '#EEEEEE',
    p_header_font_color           IN t_color        DEFAULT '#000000',
    p_header_font_family          IN t_font_family  DEFAULT c_font_family_helvetica,
    p_header_font_weight          IN t_font_weight  DEFAULT c_font_weight_bold,
    p_header_font_size            IN NUMBER         DEFAULT 10,
    --
    p_body_bg_color               IN t_color        DEFAULT '#FFFFFF',
    p_body_font_color             IN t_color        DEFAULT '#000000',
    p_body_font_family            IN t_font_family  DEFAULT c_font_family_helvetica,
    p_body_font_weight            IN t_font_weight  DEFAULT c_font_weight_normal,
    p_body_font_size              IN NUMBER         DEFAULT 10,
    --
    p_border_width                IN NUMBER         DEFAULT .5,
    p_border_color                IN t_color        DEFAULT '#666666' ) return t_print_config;


-- following experiment was to join output of two regions to create a single report
-- but this is not working :(
-- seems  ike the blob is storing the cursor location
DECLARE
    l_export_1       apex_data_export.t_export;
    l_export_2       apex_data_export.t_export;
    l_export_final   apex_data_export.t_export;
    l_region_id    number;
BEGIN

   SELECT region_id into l_region_id
     FROM apex_application_page_regions
    WHERE application_id = 333
      and page_id = 3
      and static_id = 'APPLICANT_DTL_1';
    
    l_export_1 := apex_region.export_data (
         p_format       => apex_data_export.c_format_pdf,
         p_page_id      => 3,
         p_region_id    => l_region_id );
--
--
   SELECT region_id into l_region_id
     FROM apex_application_page_regions
    WHERE application_id = 333
      and page_id = 3
      and static_id = 'APPLICANT_DTL_2';
    
    l_export_2 := apex_region.export_data (
         p_format       => apex_data_export.c_format_pdf,
         p_page_id      => 3,
         p_region_id    => l_region_id );
         
        l_export_final.file_name = l_export_1.file_name;
        l_export_final.format = l_export_1.format;
        l_export_final.mime_type = l_export_1.mime_type;
        l_export_final.as_clob = l_export_1.as_clob;
        dbms_lob.createtemporary(l_export_final.content_blob, TRUE);
        DBMS_LOB.APPEND (l_export_final.content_blob, l_export_1.content_blob);
        DBMS_LOB.APPEND (l_export_final.content_blob, l_export_2.content_blob);
        -- DBMS_LOB.APPEND (l_export_1.content_clob, l_export_2.content_clob);


    apex_data_export.download( l_export_final );
END;


type t_export is record (
    file_name                   varchar2(32767),
    format                      t_format,
    mime_type                   varchar2(32767),
    as_clob                     boolean,
    content_blob                blob,
    content_clob                clob );


-- Export Format Constants
c_format_csv                    constant t_format               := 'CSV';
c_format_html                   constant t_format               := 'HTML';
c_format_pdf                    constant t_format               := 'PDF';
c_format_xlsx                   constant t_format               := 'XLSX';
c_format_xml                    constant t_format               := 'XML';
c_format_pxml                   constant t_format               := 'PXML';
c_format_json                   constant t_format               := 'JSON';
c_format_pjson                  constant t_format               := 'PJSON';

-- Content Disposition Constants : Constants used in the DOWNLOAD procedure.
c_attachment                    constant t_content_disposition  := 'attachment';
c_inline                        constant t_content_disposition  := 'inline';

-- Font Family Constants
c_font_family_helvetica         constant t_font_family          := 'Helvetica';
c_font_family_times             constant t_font_family          := 'Times';
c_font_family_courier           constant t_font_family          := 'Courier';

-- Font Weight Constants
c_font_weight_normal            constant t_font_weight          := 'normal';
c_font_weight_bold              constant t_font_weight          := 'bold';

