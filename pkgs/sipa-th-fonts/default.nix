{
  stdenvNoCC,
  fetchzip,
  lib,
}:
stdenvNoCC.mkDerivation {
  pname = "sipa-th-fonts";
  version = "1.0.0";

  src = fetchzip {
    url = "https://oer.learn.in.th/search_detail/ZipDownload/220410";
    sha256 = "sha256-F1BWYueWPXESgKsuMIq0gZlJRDjQOJKcELatjWKJrYw=";
    extension = "zip";
    stripRoot = false;
  };

  buildPhase = ''
    mkdir -p $out/share/fonts/truetype

    cp $src/Fonts/*.ttf $out/share/fonts/truetype
  '';

  meta = with lib; {
    description = "13 ฟอนต์ฟรีมาตรฐาน จากสำนักงานส่งเสริมอุตสาหกรรมซอฟต์แวร์แห่งชาติ (SIPA)";
    longDescription = ''
      ในปี พ.ศ. 2553 ด้วยกรมทรัพย์สินทางปัญญา ร่วมกับสำนักงานส่งเสริมอุตสาหกรรมซอฟต์แวร์แห่งชาติ (องค์การมหาชน) ได้จัดโครงการประกวดผลงานสร้างสรรค์โปรแกรมคอมพิวเตอร์ฟอนต์ขึ้น เพื่อส่งเสริมให้มีการพัฒนาและสร้างสรรค์ผลงานลิขสิทธิ์โปรแกรมคอมพิวเตอร์ฟอนต์เพิ่มขึ้น เป็นการสร้างงาน สร้างทักษะ และสร้างตลาดทางด้านอุตสาหกรรมซอฟต์แวร์ของประเทศ อันจะเป็นประโยชน์ต่อสังคมและผู้บริโภคที่สามารถเลือกใช้โปรแกรมคอมพิวเตอร์ฟอนต์ที่มีความหลากลายมากขึ้นต่อไปฟอนต์ทั้งหมดนี้ฟอนต์ในโครงการเผยแพร่ฟอนต์ลิขสิทธิ์จากสำนักงานส่งเสริมอุตสาหกรรมซอฟต์แวร์แห่งชาติ (SIPA) กระทรวงเทคโนโลยีสารสนเทศและการสื่อสาร เพื่อแจกจ่ายให้ใช้อย่างเสรีปราศจากปัญหาด้านลิขสิทธิ์ เป็นความภาคภูมิใจในความเป็นชาติ และเอกลักษณ์ของความเป็นชาติไทย
    '';
    homepage = "https://www.nstda.or.th/home/news_post/thai-font/";
    license = licenses.ofl;
    platforms = platforms.all;
  };
}
