`define GTECH_default_delay 0

module DW_ahb_bcm02_96_4_32 ( a, sel, mux );
  input [95:0] a;
  input [3:0] sel;
  output [31:0] mux;
  wire   n584, n585, n586, n587, n588, n589, n590, n591, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715,
         n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726,
         n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737,
         n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748,
         n749, n750, n751, n752, n753, n754, n755, n756, n757, n758, n759,
         n760, n761, n762, n763, n764, n765, n766, n767, n768, n769, n770,
         n771, n772, n773, n774, n775, n776, n777, n778, n779, n780, n781,
         n782, n783, n784, n785, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882, n883, n884, n885, n886, n887;

  GTECH_NOT U507 ( .A(n584), .Z(mux[9]) );
  GTECH_NOR2 U508 ( .A(n585), .B(n586), .Z(n584) );
  GTECH_NOT U509 ( .A(n587), .Z(n586) );
  GTECH_NOR2 U510 ( .A(n588), .B(n589), .Z(n587) );
  GTECH_NOR2 U511 ( .A(n590), .B(n591), .Z(n589) );
  GTECH_NOT U512 ( .A(a[73]), .Z(n591) );
  GTECH_NOR2 U513 ( .A(n592), .B(n593), .Z(n588) );
  GTECH_NOT U514 ( .A(a[41]), .Z(n593) );
  GTECH_NOR2 U515 ( .A(n594), .B(n595), .Z(n585) );
  GTECH_NOT U516 ( .A(a[9]), .Z(n595) );
  GTECH_NOT U517 ( .A(n596), .Z(mux[8]) );
  GTECH_NOR2 U518 ( .A(n597), .B(n598), .Z(n596) );
  GTECH_NOT U519 ( .A(n599), .Z(n598) );
  GTECH_NOR2 U520 ( .A(n600), .B(n601), .Z(n599) );
  GTECH_NOR2 U521 ( .A(n590), .B(n602), .Z(n601) );
  GTECH_NOT U522 ( .A(a[72]), .Z(n602) );
  GTECH_NOR2 U523 ( .A(n592), .B(n603), .Z(n600) );
  GTECH_NOT U524 ( .A(a[40]), .Z(n603) );
  GTECH_NOR2 U525 ( .A(n594), .B(n604), .Z(n597) );
  GTECH_NOT U526 ( .A(a[8]), .Z(n604) );
  GTECH_NOT U527 ( .A(n605), .Z(mux[7]) );
  GTECH_NOR2 U528 ( .A(n606), .B(n607), .Z(n605) );
  GTECH_NOT U529 ( .A(n608), .Z(n607) );
  GTECH_NOR2 U530 ( .A(n609), .B(n610), .Z(n608) );
  GTECH_NOR2 U531 ( .A(n590), .B(n611), .Z(n610) );
  GTECH_NOT U532 ( .A(a[71]), .Z(n611) );
  GTECH_NOR2 U533 ( .A(n592), .B(n612), .Z(n609) );
  GTECH_NOT U534 ( .A(a[39]), .Z(n612) );
  GTECH_NOR2 U535 ( .A(n594), .B(n613), .Z(n606) );
  GTECH_NOT U536 ( .A(a[7]), .Z(n613) );
  GTECH_NOT U537 ( .A(n614), .Z(mux[6]) );
  GTECH_NOR2 U538 ( .A(n615), .B(n616), .Z(n614) );
  GTECH_NOT U539 ( .A(n617), .Z(n616) );
  GTECH_NOR2 U540 ( .A(n618), .B(n619), .Z(n617) );
  GTECH_NOR2 U541 ( .A(n590), .B(n620), .Z(n619) );
  GTECH_NOT U542 ( .A(a[70]), .Z(n620) );
  GTECH_NOR2 U543 ( .A(n592), .B(n621), .Z(n618) );
  GTECH_NOT U544 ( .A(a[38]), .Z(n621) );
  GTECH_NOR2 U545 ( .A(n594), .B(n622), .Z(n615) );
  GTECH_NOT U546 ( .A(a[6]), .Z(n622) );
  GTECH_NOT U547 ( .A(n623), .Z(mux[5]) );
  GTECH_NOR2 U548 ( .A(n624), .B(n625), .Z(n623) );
  GTECH_NOT U549 ( .A(n626), .Z(n625) );
  GTECH_NOR2 U550 ( .A(n627), .B(n628), .Z(n626) );
  GTECH_NOR2 U551 ( .A(n590), .B(n629), .Z(n628) );
  GTECH_NOT U552 ( .A(a[69]), .Z(n629) );
  GTECH_NOR2 U553 ( .A(n592), .B(n630), .Z(n627) );
  GTECH_NOT U554 ( .A(a[37]), .Z(n630) );
  GTECH_NOR2 U555 ( .A(n594), .B(n631), .Z(n624) );
  GTECH_NOT U556 ( .A(a[5]), .Z(n631) );
  GTECH_NOT U557 ( .A(n632), .Z(mux[4]) );
  GTECH_NOR2 U558 ( .A(n633), .B(n634), .Z(n632) );
  GTECH_NOT U559 ( .A(n635), .Z(n634) );
  GTECH_NOR2 U560 ( .A(n636), .B(n637), .Z(n635) );
  GTECH_NOR2 U561 ( .A(n590), .B(n638), .Z(n637) );
  GTECH_NOT U562 ( .A(a[68]), .Z(n638) );
  GTECH_NOR2 U563 ( .A(n592), .B(n639), .Z(n636) );
  GTECH_NOT U564 ( .A(a[36]), .Z(n639) );
  GTECH_NOR2 U565 ( .A(n594), .B(n640), .Z(n633) );
  GTECH_NOT U566 ( .A(a[4]), .Z(n640) );
  GTECH_NOT U567 ( .A(n641), .Z(mux[3]) );
  GTECH_NOR2 U568 ( .A(n642), .B(n643), .Z(n641) );
  GTECH_NOT U569 ( .A(n644), .Z(n643) );
  GTECH_NOR2 U570 ( .A(n645), .B(n646), .Z(n644) );
  GTECH_NOR2 U571 ( .A(n590), .B(n647), .Z(n646) );
  GTECH_NOT U572 ( .A(a[67]), .Z(n647) );
  GTECH_NOR2 U573 ( .A(n592), .B(n648), .Z(n645) );
  GTECH_NOT U574 ( .A(a[35]), .Z(n648) );
  GTECH_NOR2 U575 ( .A(n594), .B(n649), .Z(n642) );
  GTECH_NOT U576 ( .A(a[3]), .Z(n649) );
  GTECH_NOT U577 ( .A(n650), .Z(mux[31]) );
  GTECH_NOR2 U578 ( .A(n651), .B(n652), .Z(n650) );
  GTECH_NOT U579 ( .A(n653), .Z(n652) );
  GTECH_NOR2 U580 ( .A(n654), .B(n655), .Z(n653) );
  GTECH_NOR2 U581 ( .A(n590), .B(n656), .Z(n655) );
  GTECH_NOT U582 ( .A(a[95]), .Z(n656) );
  GTECH_NOR2 U583 ( .A(n592), .B(n657), .Z(n654) );
  GTECH_NOT U584 ( .A(a[63]), .Z(n657) );
  GTECH_NOR2 U585 ( .A(n594), .B(n658), .Z(n651) );
  GTECH_NOT U586 ( .A(a[31]), .Z(n658) );
  GTECH_NOT U587 ( .A(n659), .Z(mux[30]) );
  GTECH_NOR2 U588 ( .A(n660), .B(n661), .Z(n659) );
  GTECH_NOT U589 ( .A(n662), .Z(n661) );
  GTECH_NOR2 U590 ( .A(n663), .B(n664), .Z(n662) );
  GTECH_NOR2 U591 ( .A(n590), .B(n665), .Z(n664) );
  GTECH_NOT U592 ( .A(a[94]), .Z(n665) );
  GTECH_NOR2 U593 ( .A(n592), .B(n666), .Z(n663) );
  GTECH_NOT U594 ( .A(a[62]), .Z(n666) );
  GTECH_NOR2 U595 ( .A(n594), .B(n667), .Z(n660) );
  GTECH_NOT U596 ( .A(a[30]), .Z(n667) );
  GTECH_NOT U597 ( .A(n668), .Z(mux[2]) );
  GTECH_NOR2 U598 ( .A(n669), .B(n670), .Z(n668) );
  GTECH_NOT U599 ( .A(n671), .Z(n670) );
  GTECH_NOR2 U600 ( .A(n672), .B(n673), .Z(n671) );
  GTECH_NOR2 U601 ( .A(n590), .B(n674), .Z(n673) );
  GTECH_NOT U602 ( .A(a[66]), .Z(n674) );
  GTECH_NOR2 U603 ( .A(n592), .B(n675), .Z(n672) );
  GTECH_NOT U604 ( .A(a[34]), .Z(n675) );
  GTECH_NOR2 U605 ( .A(n594), .B(n676), .Z(n669) );
  GTECH_NOT U606 ( .A(a[2]), .Z(n676) );
  GTECH_NOT U607 ( .A(n677), .Z(mux[29]) );
  GTECH_NOR2 U608 ( .A(n678), .B(n679), .Z(n677) );
  GTECH_NOT U609 ( .A(n680), .Z(n679) );
  GTECH_NOR2 U610 ( .A(n681), .B(n682), .Z(n680) );
  GTECH_NOR2 U611 ( .A(n590), .B(n683), .Z(n682) );
  GTECH_NOT U612 ( .A(a[93]), .Z(n683) );
  GTECH_NOR2 U613 ( .A(n592), .B(n684), .Z(n681) );
  GTECH_NOT U614 ( .A(a[61]), .Z(n684) );
  GTECH_NOR2 U615 ( .A(n594), .B(n685), .Z(n678) );
  GTECH_NOT U616 ( .A(a[29]), .Z(n685) );
  GTECH_NOT U617 ( .A(n686), .Z(mux[28]) );
  GTECH_NOR2 U618 ( .A(n687), .B(n688), .Z(n686) );
  GTECH_NOT U619 ( .A(n689), .Z(n688) );
  GTECH_NOR2 U620 ( .A(n690), .B(n691), .Z(n689) );
  GTECH_NOR2 U621 ( .A(n590), .B(n692), .Z(n691) );
  GTECH_NOT U622 ( .A(a[92]), .Z(n692) );
  GTECH_NOR2 U623 ( .A(n592), .B(n693), .Z(n690) );
  GTECH_NOT U624 ( .A(a[60]), .Z(n693) );
  GTECH_NOR2 U625 ( .A(n594), .B(n694), .Z(n687) );
  GTECH_NOT U626 ( .A(a[28]), .Z(n694) );
  GTECH_NOT U627 ( .A(n695), .Z(mux[27]) );
  GTECH_NOR2 U628 ( .A(n696), .B(n697), .Z(n695) );
  GTECH_NOT U629 ( .A(n698), .Z(n697) );
  GTECH_NOR2 U630 ( .A(n699), .B(n700), .Z(n698) );
  GTECH_NOR2 U631 ( .A(n590), .B(n701), .Z(n700) );
  GTECH_NOT U632 ( .A(a[91]), .Z(n701) );
  GTECH_NOR2 U633 ( .A(n592), .B(n702), .Z(n699) );
  GTECH_NOT U634 ( .A(a[59]), .Z(n702) );
  GTECH_NOR2 U635 ( .A(n594), .B(n703), .Z(n696) );
  GTECH_NOT U636 ( .A(a[27]), .Z(n703) );
  GTECH_NOT U637 ( .A(n704), .Z(mux[26]) );
  GTECH_NOR2 U638 ( .A(n705), .B(n706), .Z(n704) );
  GTECH_NOT U639 ( .A(n707), .Z(n706) );
  GTECH_NOR2 U640 ( .A(n708), .B(n709), .Z(n707) );
  GTECH_NOR2 U641 ( .A(n590), .B(n710), .Z(n709) );
  GTECH_NOT U642 ( .A(a[90]), .Z(n710) );
  GTECH_NOR2 U643 ( .A(n592), .B(n711), .Z(n708) );
  GTECH_NOT U644 ( .A(a[58]), .Z(n711) );
  GTECH_NOR2 U645 ( .A(n594), .B(n712), .Z(n705) );
  GTECH_NOT U646 ( .A(a[26]), .Z(n712) );
  GTECH_NOT U647 ( .A(n713), .Z(mux[25]) );
  GTECH_NOR2 U648 ( .A(n714), .B(n715), .Z(n713) );
  GTECH_NOT U649 ( .A(n716), .Z(n715) );
  GTECH_NOR2 U650 ( .A(n717), .B(n718), .Z(n716) );
  GTECH_NOR2 U651 ( .A(n590), .B(n719), .Z(n718) );
  GTECH_NOT U652 ( .A(a[89]), .Z(n719) );
  GTECH_NOR2 U653 ( .A(n592), .B(n720), .Z(n717) );
  GTECH_NOT U654 ( .A(a[57]), .Z(n720) );
  GTECH_NOR2 U655 ( .A(n594), .B(n721), .Z(n714) );
  GTECH_NOT U656 ( .A(a[25]), .Z(n721) );
  GTECH_NOT U657 ( .A(n722), .Z(mux[24]) );
  GTECH_NOR2 U658 ( .A(n723), .B(n724), .Z(n722) );
  GTECH_NOT U659 ( .A(n725), .Z(n724) );
  GTECH_NOR2 U660 ( .A(n726), .B(n727), .Z(n725) );
  GTECH_NOR2 U661 ( .A(n590), .B(n728), .Z(n727) );
  GTECH_NOT U662 ( .A(a[88]), .Z(n728) );
  GTECH_NOR2 U663 ( .A(n592), .B(n729), .Z(n726) );
  GTECH_NOT U664 ( .A(a[56]), .Z(n729) );
  GTECH_NOR2 U665 ( .A(n594), .B(n730), .Z(n723) );
  GTECH_NOT U666 ( .A(a[24]), .Z(n730) );
  GTECH_NOT U667 ( .A(n731), .Z(mux[23]) );
  GTECH_NOR2 U668 ( .A(n732), .B(n733), .Z(n731) );
  GTECH_NOT U669 ( .A(n734), .Z(n733) );
  GTECH_NOR2 U670 ( .A(n735), .B(n736), .Z(n734) );
  GTECH_NOR2 U671 ( .A(n590), .B(n737), .Z(n736) );
  GTECH_NOT U672 ( .A(a[87]), .Z(n737) );
  GTECH_NOR2 U673 ( .A(n592), .B(n738), .Z(n735) );
  GTECH_NOT U674 ( .A(a[55]), .Z(n738) );
  GTECH_NOR2 U675 ( .A(n594), .B(n739), .Z(n732) );
  GTECH_NOT U676 ( .A(a[23]), .Z(n739) );
  GTECH_NOT U677 ( .A(n740), .Z(mux[22]) );
  GTECH_NOR2 U678 ( .A(n741), .B(n742), .Z(n740) );
  GTECH_NOT U679 ( .A(n743), .Z(n742) );
  GTECH_NOR2 U680 ( .A(n744), .B(n745), .Z(n743) );
  GTECH_NOR2 U681 ( .A(n590), .B(n746), .Z(n745) );
  GTECH_NOT U682 ( .A(a[86]), .Z(n746) );
  GTECH_NOR2 U683 ( .A(n592), .B(n747), .Z(n744) );
  GTECH_NOT U684 ( .A(a[54]), .Z(n747) );
  GTECH_NOR2 U685 ( .A(n594), .B(n748), .Z(n741) );
  GTECH_NOT U686 ( .A(a[22]), .Z(n748) );
  GTECH_NOT U687 ( .A(n749), .Z(mux[21]) );
  GTECH_NOR2 U688 ( .A(n750), .B(n751), .Z(n749) );
  GTECH_NOT U689 ( .A(n752), .Z(n751) );
  GTECH_NOR2 U690 ( .A(n753), .B(n754), .Z(n752) );
  GTECH_NOR2 U691 ( .A(n590), .B(n755), .Z(n754) );
  GTECH_NOT U692 ( .A(a[85]), .Z(n755) );
  GTECH_NOR2 U693 ( .A(n592), .B(n756), .Z(n753) );
  GTECH_NOT U694 ( .A(a[53]), .Z(n756) );
  GTECH_NOR2 U695 ( .A(n594), .B(n757), .Z(n750) );
  GTECH_NOT U696 ( .A(a[21]), .Z(n757) );
  GTECH_NOT U697 ( .A(n758), .Z(mux[20]) );
  GTECH_NOR2 U698 ( .A(n759), .B(n760), .Z(n758) );
  GTECH_NOT U699 ( .A(n761), .Z(n760) );
  GTECH_NOR2 U700 ( .A(n762), .B(n763), .Z(n761) );
  GTECH_NOR2 U701 ( .A(n590), .B(n764), .Z(n763) );
  GTECH_NOT U702 ( .A(a[84]), .Z(n764) );
  GTECH_NOR2 U703 ( .A(n592), .B(n765), .Z(n762) );
  GTECH_NOT U704 ( .A(a[52]), .Z(n765) );
  GTECH_NOR2 U705 ( .A(n594), .B(n766), .Z(n759) );
  GTECH_NOT U706 ( .A(a[20]), .Z(n766) );
  GTECH_NOT U707 ( .A(n767), .Z(mux[1]) );
  GTECH_NOR2 U708 ( .A(n768), .B(n769), .Z(n767) );
  GTECH_NOT U709 ( .A(n770), .Z(n769) );
  GTECH_NOR2 U710 ( .A(n771), .B(n772), .Z(n770) );
  GTECH_NOR2 U711 ( .A(n590), .B(n773), .Z(n772) );
  GTECH_NOT U712 ( .A(a[65]), .Z(n773) );
  GTECH_NOR2 U713 ( .A(n592), .B(n774), .Z(n771) );
  GTECH_NOT U714 ( .A(a[33]), .Z(n774) );
  GTECH_NOR2 U715 ( .A(n594), .B(n775), .Z(n768) );
  GTECH_NOT U716 ( .A(a[1]), .Z(n775) );
  GTECH_NOT U717 ( .A(n776), .Z(mux[19]) );
  GTECH_NOR2 U718 ( .A(n777), .B(n778), .Z(n776) );
  GTECH_NOT U719 ( .A(n779), .Z(n778) );
  GTECH_NOR2 U720 ( .A(n780), .B(n781), .Z(n779) );
  GTECH_NOR2 U721 ( .A(n590), .B(n782), .Z(n781) );
  GTECH_NOT U722 ( .A(a[83]), .Z(n782) );
  GTECH_NOR2 U723 ( .A(n592), .B(n783), .Z(n780) );
  GTECH_NOT U724 ( .A(a[51]), .Z(n783) );
  GTECH_NOR2 U725 ( .A(n594), .B(n784), .Z(n777) );
  GTECH_NOT U726 ( .A(a[19]), .Z(n784) );
  GTECH_NOT U727 ( .A(n785), .Z(mux[18]) );
  GTECH_NOR2 U728 ( .A(n786), .B(n787), .Z(n785) );
  GTECH_NOT U729 ( .A(n788), .Z(n787) );
  GTECH_NOR2 U730 ( .A(n789), .B(n790), .Z(n788) );
  GTECH_NOR2 U731 ( .A(n590), .B(n791), .Z(n790) );
  GTECH_NOT U732 ( .A(a[82]), .Z(n791) );
  GTECH_NOR2 U733 ( .A(n592), .B(n792), .Z(n789) );
  GTECH_NOT U734 ( .A(a[50]), .Z(n792) );
  GTECH_NOR2 U735 ( .A(n594), .B(n793), .Z(n786) );
  GTECH_NOT U736 ( .A(a[18]), .Z(n793) );
  GTECH_NOT U737 ( .A(n794), .Z(mux[17]) );
  GTECH_NOR2 U738 ( .A(n795), .B(n796), .Z(n794) );
  GTECH_NOT U739 ( .A(n797), .Z(n796) );
  GTECH_NOR2 U740 ( .A(n798), .B(n799), .Z(n797) );
  GTECH_NOR2 U741 ( .A(n590), .B(n800), .Z(n799) );
  GTECH_NOT U742 ( .A(a[81]), .Z(n800) );
  GTECH_NOR2 U743 ( .A(n592), .B(n801), .Z(n798) );
  GTECH_NOT U744 ( .A(a[49]), .Z(n801) );
  GTECH_NOR2 U745 ( .A(n594), .B(n802), .Z(n795) );
  GTECH_NOT U746 ( .A(a[17]), .Z(n802) );
  GTECH_NOT U747 ( .A(n803), .Z(mux[16]) );
  GTECH_NOR2 U748 ( .A(n804), .B(n805), .Z(n803) );
  GTECH_NOT U749 ( .A(n806), .Z(n805) );
  GTECH_NOR2 U750 ( .A(n807), .B(n808), .Z(n806) );
  GTECH_NOR2 U751 ( .A(n590), .B(n809), .Z(n808) );
  GTECH_NOT U752 ( .A(a[80]), .Z(n809) );
  GTECH_NOR2 U753 ( .A(n592), .B(n810), .Z(n807) );
  GTECH_NOT U754 ( .A(a[48]), .Z(n810) );
  GTECH_NOR2 U755 ( .A(n594), .B(n811), .Z(n804) );
  GTECH_NOT U756 ( .A(a[16]), .Z(n811) );
  GTECH_NOT U757 ( .A(n812), .Z(mux[15]) );
  GTECH_NOR2 U758 ( .A(n813), .B(n814), .Z(n812) );
  GTECH_NOT U759 ( .A(n815), .Z(n814) );
  GTECH_NOR2 U760 ( .A(n816), .B(n817), .Z(n815) );
  GTECH_NOR2 U761 ( .A(n590), .B(n818), .Z(n817) );
  GTECH_NOT U762 ( .A(a[79]), .Z(n818) );
  GTECH_NOR2 U763 ( .A(n592), .B(n819), .Z(n816) );
  GTECH_NOT U764 ( .A(a[47]), .Z(n819) );
  GTECH_NOR2 U765 ( .A(n594), .B(n820), .Z(n813) );
  GTECH_NOT U766 ( .A(a[15]), .Z(n820) );
  GTECH_NOT U767 ( .A(n821), .Z(mux[14]) );
  GTECH_NOR2 U768 ( .A(n822), .B(n823), .Z(n821) );
  GTECH_NOT U769 ( .A(n824), .Z(n823) );
  GTECH_NOR2 U770 ( .A(n825), .B(n826), .Z(n824) );
  GTECH_NOR2 U771 ( .A(n590), .B(n827), .Z(n826) );
  GTECH_NOT U772 ( .A(a[78]), .Z(n827) );
  GTECH_NOR2 U773 ( .A(n592), .B(n828), .Z(n825) );
  GTECH_NOT U774 ( .A(a[46]), .Z(n828) );
  GTECH_NOR2 U775 ( .A(n594), .B(n829), .Z(n822) );
  GTECH_NOT U776 ( .A(a[14]), .Z(n829) );
  GTECH_NOT U777 ( .A(n830), .Z(mux[13]) );
  GTECH_NOR2 U778 ( .A(n831), .B(n832), .Z(n830) );
  GTECH_NOT U779 ( .A(n833), .Z(n832) );
  GTECH_NOR2 U780 ( .A(n834), .B(n835), .Z(n833) );
  GTECH_NOR2 U781 ( .A(n590), .B(n836), .Z(n835) );
  GTECH_NOT U782 ( .A(a[77]), .Z(n836) );
  GTECH_NOR2 U783 ( .A(n592), .B(n837), .Z(n834) );
  GTECH_NOT U784 ( .A(a[45]), .Z(n837) );
  GTECH_NOR2 U785 ( .A(n594), .B(n838), .Z(n831) );
  GTECH_NOT U786 ( .A(a[13]), .Z(n838) );
  GTECH_NOT U787 ( .A(n839), .Z(mux[12]) );
  GTECH_NOR2 U788 ( .A(n840), .B(n841), .Z(n839) );
  GTECH_NOT U789 ( .A(n842), .Z(n841) );
  GTECH_NOR2 U790 ( .A(n843), .B(n844), .Z(n842) );
  GTECH_NOR2 U791 ( .A(n590), .B(n845), .Z(n844) );
  GTECH_NOT U792 ( .A(a[76]), .Z(n845) );
  GTECH_NOR2 U793 ( .A(n592), .B(n846), .Z(n843) );
  GTECH_NOT U794 ( .A(a[44]), .Z(n846) );
  GTECH_NOR2 U795 ( .A(n594), .B(n847), .Z(n840) );
  GTECH_NOT U796 ( .A(a[12]), .Z(n847) );
  GTECH_NOT U797 ( .A(n848), .Z(mux[11]) );
  GTECH_NOR2 U798 ( .A(n849), .B(n850), .Z(n848) );
  GTECH_NOT U799 ( .A(n851), .Z(n850) );
  GTECH_NOR2 U800 ( .A(n852), .B(n853), .Z(n851) );
  GTECH_NOR2 U801 ( .A(n590), .B(n854), .Z(n853) );
  GTECH_NOT U802 ( .A(a[75]), .Z(n854) );
  GTECH_NOR2 U803 ( .A(n592), .B(n855), .Z(n852) );
  GTECH_NOT U804 ( .A(a[43]), .Z(n855) );
  GTECH_NOR2 U805 ( .A(n594), .B(n856), .Z(n849) );
  GTECH_NOT U806 ( .A(a[11]), .Z(n856) );
  GTECH_NOT U807 ( .A(n857), .Z(mux[10]) );
  GTECH_NOR2 U808 ( .A(n858), .B(n859), .Z(n857) );
  GTECH_NOT U809 ( .A(n860), .Z(n859) );
  GTECH_NOR2 U810 ( .A(n861), .B(n862), .Z(n860) );
  GTECH_NOR2 U811 ( .A(n590), .B(n863), .Z(n862) );
  GTECH_NOT U812 ( .A(a[74]), .Z(n863) );
  GTECH_NOR2 U813 ( .A(n592), .B(n864), .Z(n861) );
  GTECH_NOT U814 ( .A(a[42]), .Z(n864) );
  GTECH_NOR2 U815 ( .A(n594), .B(n865), .Z(n858) );
  GTECH_NOT U816 ( .A(a[10]), .Z(n865) );
  GTECH_NOT U817 ( .A(n866), .Z(mux[0]) );
  GTECH_NOR2 U818 ( .A(n867), .B(n868), .Z(n866) );
  GTECH_NOT U819 ( .A(n869), .Z(n868) );
  GTECH_NOR2 U820 ( .A(n870), .B(n871), .Z(n869) );
  GTECH_NOR2 U821 ( .A(n590), .B(n872), .Z(n871) );
  GTECH_NOT U822 ( .A(a[64]), .Z(n872) );
  GTECH_NOT U823 ( .A(n873), .Z(n590) );
  GTECH_NOR2 U824 ( .A(n874), .B(n875), .Z(n873) );
  GTECH_NOT U825 ( .A(n876), .Z(n875) );
  GTECH_NOR2 U826 ( .A(sel[0]), .B(n877), .Z(n876) );
  GTECH_NOT U827 ( .A(sel[1]), .Z(n874) );
  GTECH_NOR2 U828 ( .A(n592), .B(n878), .Z(n870) );
  GTECH_NOT U829 ( .A(a[32]), .Z(n878) );
  GTECH_NOT U830 ( .A(n879), .Z(n592) );
  GTECH_NOR2 U831 ( .A(n880), .B(n881), .Z(n879) );
  GTECH_NOT U832 ( .A(n882), .Z(n881) );
  GTECH_NOR2 U833 ( .A(sel[1]), .B(n877), .Z(n882) );
  GTECH_NOT U834 ( .A(sel[0]), .Z(n880) );
  GTECH_NOR2 U835 ( .A(n594), .B(n883), .Z(n867) );
  GTECH_NOT U836 ( .A(a[0]), .Z(n883) );
  GTECH_NOT U837 ( .A(n884), .Z(n594) );
  GTECH_NOR2 U838 ( .A(n877), .B(n885), .Z(n884) );
  GTECH_NOT U839 ( .A(n886), .Z(n885) );
  GTECH_NOR2 U840 ( .A(sel[1]), .B(sel[0]), .Z(n886) );
  GTECH_NOT U841 ( .A(n887), .Z(n877) );
  GTECH_NOR2 U842 ( .A(sel[3]), .B(sel[2]), .Z(n887) );
endmodule


module DW_ahb_bcm02_6_4_2 ( a, sel, mux );
  input [5:0] a;
  input [3:0] sel;
  output [1:0] mux;
  wire   n74, n75, n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107;

  GTECH_NOT U57 ( .A(n74), .Z(mux[1]) );
  GTECH_NOR2 U58 ( .A(n75), .B(n76), .Z(n74) );
  GTECH_NOT U59 ( .A(n77), .Z(n76) );
  GTECH_NOR2 U60 ( .A(n78), .B(n79), .Z(n77) );
  GTECH_NOR2 U61 ( .A(n80), .B(n81), .Z(n79) );
  GTECH_NOT U62 ( .A(a[5]), .Z(n81) );
  GTECH_NOR2 U63 ( .A(n82), .B(n83), .Z(n78) );
  GTECH_NOT U64 ( .A(a[3]), .Z(n83) );
  GTECH_NOR2 U65 ( .A(n84), .B(n85), .Z(n75) );
  GTECH_NOT U66 ( .A(a[1]), .Z(n85) );
  GTECH_NOT U67 ( .A(n86), .Z(mux[0]) );
  GTECH_NOR2 U68 ( .A(n87), .B(n88), .Z(n86) );
  GTECH_NOT U69 ( .A(n89), .Z(n88) );
  GTECH_NOR2 U70 ( .A(n90), .B(n91), .Z(n89) );
  GTECH_NOR2 U71 ( .A(n80), .B(n92), .Z(n91) );
  GTECH_NOT U72 ( .A(a[4]), .Z(n92) );
  GTECH_NOT U73 ( .A(n93), .Z(n80) );
  GTECH_NOR2 U74 ( .A(n94), .B(n95), .Z(n93) );
  GTECH_NOT U75 ( .A(n96), .Z(n95) );
  GTECH_NOR2 U76 ( .A(sel[0]), .B(n97), .Z(n96) );
  GTECH_NOT U77 ( .A(sel[1]), .Z(n94) );
  GTECH_NOR2 U78 ( .A(n82), .B(n98), .Z(n90) );
  GTECH_NOT U79 ( .A(a[2]), .Z(n98) );
  GTECH_NOT U80 ( .A(n99), .Z(n82) );
  GTECH_NOR2 U81 ( .A(n100), .B(n101), .Z(n99) );
  GTECH_NOT U82 ( .A(n102), .Z(n101) );
  GTECH_NOR2 U83 ( .A(sel[1]), .B(n97), .Z(n102) );
  GTECH_NOT U84 ( .A(sel[0]), .Z(n100) );
  GTECH_NOR2 U85 ( .A(n84), .B(n103), .Z(n87) );
  GTECH_NOT U86 ( .A(a[0]), .Z(n103) );
  GTECH_NOT U87 ( .A(n104), .Z(n84) );
  GTECH_NOR2 U88 ( .A(n97), .B(n105), .Z(n104) );
  GTECH_NOT U89 ( .A(n106), .Z(n105) );
  GTECH_NOR2 U90 ( .A(sel[1]), .B(sel[0]), .Z(n106) );
  GTECH_NOT U91 ( .A(n107), .Z(n97) );
  GTECH_NOR2 U92 ( .A(sel[3]), .B(sel[2]), .Z(n107) );
endmodule


module DW_ahb_bcm02_9_4_3 ( a, sel, mux );
  input [8:0] a;
  input [3:0] sel;
  output [2:0] mux;
  wire   n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n129, n130, n131, n132, n133;

  GTECH_NOT U72 ( .A(n91), .Z(mux[2]) );
  GTECH_NOR2 U73 ( .A(n92), .B(n93), .Z(n91) );
  GTECH_NOT U74 ( .A(n94), .Z(n93) );
  GTECH_NOR2 U75 ( .A(n95), .B(n96), .Z(n94) );
  GTECH_NOR2 U76 ( .A(n97), .B(n98), .Z(n96) );
  GTECH_NOT U77 ( .A(a[8]), .Z(n98) );
  GTECH_NOR2 U78 ( .A(n99), .B(n100), .Z(n95) );
  GTECH_NOT U79 ( .A(a[5]), .Z(n100) );
  GTECH_NOR2 U80 ( .A(n101), .B(n102), .Z(n92) );
  GTECH_NOT U81 ( .A(a[2]), .Z(n102) );
  GTECH_NOT U82 ( .A(n103), .Z(mux[1]) );
  GTECH_NOR2 U83 ( .A(n104), .B(n105), .Z(n103) );
  GTECH_NOT U84 ( .A(n106), .Z(n105) );
  GTECH_NOR2 U85 ( .A(n107), .B(n108), .Z(n106) );
  GTECH_NOR2 U86 ( .A(n97), .B(n109), .Z(n108) );
  GTECH_NOT U87 ( .A(a[7]), .Z(n109) );
  GTECH_NOR2 U88 ( .A(n99), .B(n110), .Z(n107) );
  GTECH_NOT U89 ( .A(a[4]), .Z(n110) );
  GTECH_NOR2 U90 ( .A(n101), .B(n111), .Z(n104) );
  GTECH_NOT U91 ( .A(a[1]), .Z(n111) );
  GTECH_NOT U92 ( .A(n112), .Z(mux[0]) );
  GTECH_NOR2 U93 ( .A(n113), .B(n114), .Z(n112) );
  GTECH_NOT U94 ( .A(n115), .Z(n114) );
  GTECH_NOR2 U95 ( .A(n116), .B(n117), .Z(n115) );
  GTECH_NOR2 U96 ( .A(n97), .B(n118), .Z(n117) );
  GTECH_NOT U97 ( .A(a[6]), .Z(n118) );
  GTECH_NOT U98 ( .A(n119), .Z(n97) );
  GTECH_NOR2 U99 ( .A(n120), .B(n121), .Z(n119) );
  GTECH_NOT U100 ( .A(n122), .Z(n121) );
  GTECH_NOR2 U101 ( .A(sel[0]), .B(n123), .Z(n122) );
  GTECH_NOT U102 ( .A(sel[1]), .Z(n120) );
  GTECH_NOR2 U103 ( .A(n99), .B(n124), .Z(n116) );
  GTECH_NOT U104 ( .A(a[3]), .Z(n124) );
  GTECH_NOT U105 ( .A(n125), .Z(n99) );
  GTECH_NOR2 U106 ( .A(n126), .B(n127), .Z(n125) );
  GTECH_NOT U107 ( .A(n128), .Z(n127) );
  GTECH_NOR2 U108 ( .A(sel[1]), .B(n123), .Z(n128) );
  GTECH_NOT U109 ( .A(sel[0]), .Z(n126) );
  GTECH_NOR2 U110 ( .A(n101), .B(n129), .Z(n113) );
  GTECH_NOT U111 ( .A(a[0]), .Z(n129) );
  GTECH_NOT U112 ( .A(n130), .Z(n101) );
  GTECH_NOR2 U113 ( .A(n123), .B(n131), .Z(n130) );
  GTECH_NOT U114 ( .A(n132), .Z(n131) );
  GTECH_NOR2 U115 ( .A(sel[1]), .B(sel[0]), .Z(n132) );
  GTECH_NOT U116 ( .A(n133), .Z(n123) );
  GTECH_NOR2 U117 ( .A(sel[3]), .B(sel[2]), .Z(n133) );
endmodule


module DW_ahb_bcm02_12_4_4 ( a, sel, mux );
  input [11:0] a;
  input [3:0] sel;
  output [3:0] mux;
  wire   n108, n109, n110, n111, n112, n113, n114, n115, n116, n117, n118,
         n119, n120, n121, n122, n123, n124, n125, n126, n127, n128, n129,
         n130, n131, n132, n133, n134, n135, n136, n137, n138, n139, n140,
         n141, n142, n143, n144, n145, n146, n147, n148, n149, n150, n151,
         n152, n153, n154, n155, n156, n157, n158, n159;

  GTECH_NOT U87 ( .A(n108), .Z(mux[3]) );
  GTECH_NOR2 U88 ( .A(n109), .B(n110), .Z(n108) );
  GTECH_NOT U89 ( .A(n111), .Z(n110) );
  GTECH_NOR2 U90 ( .A(n112), .B(n113), .Z(n111) );
  GTECH_NOR2 U91 ( .A(n114), .B(n115), .Z(n113) );
  GTECH_NOT U92 ( .A(a[11]), .Z(n115) );
  GTECH_NOR2 U93 ( .A(n116), .B(n117), .Z(n112) );
  GTECH_NOT U94 ( .A(a[7]), .Z(n117) );
  GTECH_NOR2 U95 ( .A(n118), .B(n119), .Z(n109) );
  GTECH_NOT U96 ( .A(a[3]), .Z(n119) );
  GTECH_NOT U97 ( .A(n120), .Z(mux[2]) );
  GTECH_NOR2 U98 ( .A(n121), .B(n122), .Z(n120) );
  GTECH_NOT U99 ( .A(n123), .Z(n122) );
  GTECH_NOR2 U100 ( .A(n124), .B(n125), .Z(n123) );
  GTECH_NOR2 U101 ( .A(n114), .B(n126), .Z(n125) );
  GTECH_NOT U102 ( .A(a[10]), .Z(n126) );
  GTECH_NOR2 U103 ( .A(n116), .B(n127), .Z(n124) );
  GTECH_NOT U104 ( .A(a[6]), .Z(n127) );
  GTECH_NOR2 U105 ( .A(n118), .B(n128), .Z(n121) );
  GTECH_NOT U106 ( .A(a[2]), .Z(n128) );
  GTECH_NOT U107 ( .A(n129), .Z(mux[1]) );
  GTECH_NOR2 U108 ( .A(n130), .B(n131), .Z(n129) );
  GTECH_NOT U109 ( .A(n132), .Z(n131) );
  GTECH_NOR2 U110 ( .A(n133), .B(n134), .Z(n132) );
  GTECH_NOR2 U111 ( .A(n114), .B(n135), .Z(n134) );
  GTECH_NOT U112 ( .A(a[9]), .Z(n135) );
  GTECH_NOR2 U113 ( .A(n116), .B(n136), .Z(n133) );
  GTECH_NOT U114 ( .A(a[5]), .Z(n136) );
  GTECH_NOR2 U115 ( .A(n118), .B(n137), .Z(n130) );
  GTECH_NOT U116 ( .A(a[1]), .Z(n137) );
  GTECH_NOT U117 ( .A(n138), .Z(mux[0]) );
  GTECH_NOR2 U118 ( .A(n139), .B(n140), .Z(n138) );
  GTECH_NOT U119 ( .A(n141), .Z(n140) );
  GTECH_NOR2 U120 ( .A(n142), .B(n143), .Z(n141) );
  GTECH_NOR2 U121 ( .A(n114), .B(n144), .Z(n143) );
  GTECH_NOT U122 ( .A(a[8]), .Z(n144) );
  GTECH_NOT U123 ( .A(n145), .Z(n114) );
  GTECH_NOR2 U124 ( .A(n146), .B(n147), .Z(n145) );
  GTECH_NOT U125 ( .A(n148), .Z(n147) );
  GTECH_NOR2 U126 ( .A(sel[0]), .B(n149), .Z(n148) );
  GTECH_NOT U127 ( .A(sel[1]), .Z(n146) );
  GTECH_NOR2 U128 ( .A(n116), .B(n150), .Z(n142) );
  GTECH_NOT U129 ( .A(a[4]), .Z(n150) );
  GTECH_NOT U130 ( .A(n151), .Z(n116) );
  GTECH_NOR2 U131 ( .A(n152), .B(n153), .Z(n151) );
  GTECH_NOT U132 ( .A(n154), .Z(n153) );
  GTECH_NOR2 U133 ( .A(sel[1]), .B(n149), .Z(n154) );
  GTECH_NOT U134 ( .A(sel[0]), .Z(n152) );
  GTECH_NOR2 U135 ( .A(n118), .B(n155), .Z(n139) );
  GTECH_NOT U136 ( .A(a[0]), .Z(n155) );
  GTECH_NOT U137 ( .A(n156), .Z(n118) );
  GTECH_NOR2 U138 ( .A(n149), .B(n157), .Z(n156) );
  GTECH_NOT U139 ( .A(n158), .Z(n157) );
  GTECH_NOR2 U140 ( .A(sel[1]), .B(sel[0]), .Z(n158) );
  GTECH_NOT U141 ( .A(n159), .Z(n149) );
  GTECH_NOR2 U142 ( .A(sel[3]), .B(sel[2]), .Z(n159) );
endmodule


module DW_ahb_bcm02_3_4_1 ( a, sel, mux );
  input [2:0] a;
  input [3:0] sel;
  output [0:0] mux;
  wire   n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68, n69, n70,
         n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81;

  GTECH_NOT U42 ( .A(n57), .Z(mux[0]) );
  GTECH_NOR2 U43 ( .A(n58), .B(n59), .Z(n57) );
  GTECH_NOT U44 ( .A(n60), .Z(n59) );
  GTECH_NOR2 U45 ( .A(n61), .B(n62), .Z(n60) );
  GTECH_NOR2 U46 ( .A(n63), .B(n64), .Z(n62) );
  GTECH_NOT U47 ( .A(n65), .Z(n64) );
  GTECH_NOR2 U48 ( .A(n66), .B(n67), .Z(n65) );
  GTECH_NOT U49 ( .A(n68), .Z(n67) );
  GTECH_NOR2 U50 ( .A(sel[0]), .B(n69), .Z(n68) );
  GTECH_NOT U51 ( .A(a[2]), .Z(n66) );
  GTECH_NOT U52 ( .A(sel[1]), .Z(n63) );
  GTECH_NOR2 U53 ( .A(sel[1]), .B(n70), .Z(n61) );
  GTECH_NOT U54 ( .A(n71), .Z(n70) );
  GTECH_NOR2 U55 ( .A(n72), .B(n73), .Z(n71) );
  GTECH_NOT U56 ( .A(n74), .Z(n73) );
  GTECH_NOR2 U57 ( .A(n75), .B(n69), .Z(n74) );
  GTECH_NOT U58 ( .A(a[0]), .Z(n72) );
  GTECH_NOR2 U59 ( .A(n76), .B(n77), .Z(n58) );
  GTECH_NOT U60 ( .A(a[1]), .Z(n77) );
  GTECH_NOT U61 ( .A(n75), .Z(n76) );
  GTECH_NOR2 U62 ( .A(n78), .B(n79), .Z(n75) );
  GTECH_NOT U63 ( .A(n80), .Z(n79) );
  GTECH_NOR2 U64 ( .A(sel[1]), .B(n69), .Z(n80) );
  GTECH_NOT U65 ( .A(n81), .Z(n69) );
  GTECH_NOR2 U66 ( .A(sel[3]), .B(sel[2]), .Z(n81) );
  GTECH_NOT U67 ( .A(sel[0]), .Z(n78) );
endmodule


module DW_ahb_mux_32_32 ( hclk, hresetn, bus_haddr, bus_hburst, hmaster, 
        bus_hprot, bus_hsize, bus_htrans, bus_hwdata, bus_hwrite, hrdata_none, 
        hready_resp_none, hresp_none, bus_hready, bus_hresp, bus_hrdata, hsel, 
        hmaster_data, haddr, hburst, hprot, hsize, htrans, hwdata, hwrite, 
        hrdata, hready, hresp );
  input [95:0] bus_haddr;
  input [8:0] bus_hburst;
  input [3:0] hmaster;
  input [11:0] bus_hprot;
  input [8:0] bus_hsize;
  input [5:0] bus_htrans;
  input [95:0] bus_hwdata;
  input [2:0] bus_hwrite;
  input [31:0] hrdata_none;
  input [1:0] hresp_none;
  input [4:0] bus_hready;
  input [9:0] bus_hresp;
  input [159:0] bus_hrdata;
  input [4:0] hsel;
  output [3:0] hmaster_data;
  output [31:0] haddr;
  output [2:0] hburst;
  output [3:0] hprot;
  output [2:0] hsize;
  output [1:0] htrans;
  output [31:0] hwdata;
  output [31:0] hrdata;
  output [1:0] hresp;
  input hclk, hresetn, hready_resp_none;
  output hwrite, hready;
  wire   n770, n771, n772, n773, n776, n777, n778, n779, n780, n814, n815,
         n816, n817, n818, n819, n820, n821, n822, n823, n824, n825, n826,
         n827, n828, n829, n830, n831, n832, n833, n834, n835, n836, n837,
         n838, n839, n840, n841, n842, n843, n844, n845, n846, n847, n848,
         n849, n850, n851, n852, n853, n854, n855, n856, n857, n858, n859,
         n860, n861, n862, n863, n864, n865, n866, n867, n868, n869, n870,
         n871, n872, n873, n874, n875, n876, n877, n878, n879, n880, n881,
         n882, n883, n884, n885, n886, n887, n888, n889, n890, n891, n892,
         n893, n894, n895, n896, n897, n898, n899, n900, n901, n902, n903,
         n904, n905, n906, n907, n908, n909, n910, n911, n912, n913, n914,
         n915, n916, n917, n918, n919, n920, n921, n922, n923, n924, n925,
         n926, n927, n928, n929, n930, n931, n932, n933, n934, n935, n936,
         n937, n938, n939, n940, n941, n942, n943, n944, n945, n946, n947,
         n948, n949, n950, n951, n952, n953, n954, n955, n956, n957, n958,
         n959, n960, n961, n962, n963, n964, n965, n966, n967, n968, n969,
         n970, n971, n972, n973, n974, n975, n976, n977, n978, n979, n980,
         n981, n982, n983, n984, n985, n986, n987, n988, n989, n990, n991,
         n992, n993, n994, n995, n996, n997, n998, n999, n1000, n1001, n1002,
         n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011, n1012,
         n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021, n1022,
         n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031, n1032,
         n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041, n1042,
         n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051, n1052,
         n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060, n1061, n1062,
         n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070, n1071, n1072,
         n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081, n1082,
         n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090, n1091, n1092,
         n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100, n1101, n1102,
         n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110, n1111, n1112,
         n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1120, n1121, n1122,
         n1123, n1124, n1125, n1126, n1127, n1128, n1129, n1130, n1131, n1132,
         n1133, n1134, n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142,
         n1143, n1144, n1145, n1146, n1147, n1148, n1149, n1150, n1151, n1152,
         n1153, n1154, n1155, n1156, n1157, n1158, n1159, n1160, n1161, n1162,
         n1163, n1164, n1165, n1166, n1167, n1168, n1169, n1170, n1171, n1172,
         n1173, n1174, n1175, n1176, n1177, n1178, n1179, n1180, n1181, n1182,
         n1183, n1184, n1185, n1186, n1187, n1188, n1189, n1190, n1191, n1192,
         n1193, n1194, n1195, n1196, n1197, n1198, n1199, n1200, n1201, n1202,
         n1203, n1204, n1205, n1206, n1207, n1208, n1209, n1210, n1211, n1212,
         n1213, n1214, n1215, n1216, n1217, n1218, n1219, n1220, n1221, n1222,
         n1223, n1224, n1225, n1226, n1227, n1228, n1229, n1230, n1231, n1232,
         n1233, n1234, n1235, n1236, n1237, n1238, n1239, n1240, n1241, n1242,
         n1243, n1244, n1245, n1246, n1247, n1248, n1249, n1250, n1251, n1252,
         n1253, n1254, n1255, n1256, n1257, n1258, n1259, n1260, n1261, n1262,
         n1263, n1264, n1265, n1266, n1267, n1268, n1269, n1270, n1271, n1272,
         n1273, n1274, n1275, n1276, n1277, n1278, n1279, n1280, n1281, n1282,
         n1283, n1284, n1285, n1286, n1287, n1288, n1289, n1290, n1291, n1292,
         n1293, n1294, n1295, n1296, n1297, n1298, n1299, n1300, n1301, n1302,
         n1303, n1304, n1305, n1306, n1307, n1308, n1309, n1310, n1311, n1312,
         n1313, n1314, n1315, n1316, n1317, n1318, n1319, n1320, n1321, n1322,
         n1323, n1324, n1325, n1326, n1327, n1328, n1329, n1330, n1331, n1332,
         n1333, n1334, n1335, n1336, n1337, n1338, n1339, n1340, n1341, n1342,
         n1343, n1344, n1345, n1346, n1347, n1348, n1349, n1350, n1351, n1352,
         n1353, n1354, n1355, n1356, n1357, n1358, n1359, n1360, n1361, n1362,
         n1363, n1364, n1365, n1366, n1367, n1368, n1369, n1370, n1371, n1372,
         n1373, n1374, n1375, n1376, n1377, n1378, n1379, n1380, n1381, n1382,
         n1383, n1384, n1385, n1386, n1387, n1388, n1389, n1390, n1391, n1392,
         n1393, n1394, n1395, n1396, n1397, n1398, n1399, n1400, n1401, n1402,
         n1403, n1404, n1405, n1406, n1407, n1408, n1409, n1410, n1411, n1412,
         n1413, n1414, n1415, n1416, n1417, n1418, n1419, n1420, n1421, n1422,
         n1423, n1424, n1425, n1426, n1427, n1428, n1429, n1430, n1431, n1432,
         n1433, n1434, n1435, n1436, n1437, n1438, n1439, n1440, n1441, n1442,
         n1443, n1444, n1445, n1446, n1447, n1448, n1449, n1450, n1451, n1452,
         n1453, n1454, n1455, n1456, n1457, n1458, n1459, n1460, n1461, n1462,
         n1463, n1464, n1465, n1466, n1467, n1468, n1469, n1470, n1471, n1472,
         n1473, n1474, n1475, n1476, n1477, n1478, n1479, n1480, n1481, n1482,
         n1483, n1484, n1485, n1486, n1487, n1488, n1489, n1490, n1491, n1492,
         n1493, n1494, n1495, n1496, n1497, n1498, n1499, n1500, n1501, n1502,
         n1503, n1504, n1505, n1506, n1507, n1508, n1509, n1510, n1511, n1512,
         n1513, n1514, n1515, n1516, n1517, n1518, n1519, n1520, n1521, n1522,
         n1523, n1524, n1525, n1526, n1527, n1528, n1529, n1530, n1531, n1532,
         n1533, n1534, n1535, n1536, n1537, n1538, n1539, n1540, n1541, n1542,
         n1543, n1544, n1545, n1546, n1547, n1548, n1549, n1550, n1551, n1552,
         n1553, n1554, n1555, n1556, n1557, n1558, n1559, n1560, n1561, n1562,
         n1563, n1564, n1565, n1566, n1567, n1568, n1569, n1570, n1571, n1572,
         n1573, n1574, n1575, n1576, n1577, n1578, n1579, n1580, n1581, n1582,
         n1583, n1584, n1585, n1586;
  wire   [4:0] hsel_prev;
  assign hmaster_data[3] = 1'b0;
  assign hmaster_data[2] = 1'b0;

  DW_ahb_bcm02_96_4_32 U_a ( .a(bus_haddr), .sel(hmaster), .mux(haddr) );
  DW_ahb_bcm02_6_4_2 U_t ( .a(bus_htrans), .sel(hmaster), .mux(htrans) );
  DW_ahb_bcm02_9_4_3 U_b ( .a(bus_hburst), .sel(hmaster), .mux(hburst) );
  DW_ahb_bcm02_9_4_3 U_s ( .a(bus_hsize), .sel(hmaster), .mux(hsize) );
  DW_ahb_bcm02_12_4_4 U_p ( .a(bus_hprot), .sel(hmaster), .mux(hprot) );
  DW_ahb_bcm02_3_4_1 U_hw ( .a(bus_hwrite), .sel(hmaster), .mux(hwrite) );
  DW_ahb_bcm02_96_4_32 U_dm ( .a(bus_hwdata), .sel({1'b0, 1'b0, 
        hmaster_data[1:0]}), .mux(hwdata) );
  GTECH_FD2 hsel_prev_reg_0_ ( .D(n780), .CP(hclk), .CD(hresetn), .Q(
        hsel_prev[0]), .QN(n818) );
  GTECH_FD2 hsel_prev_reg_1_ ( .D(n776), .CP(hclk), .CD(hresetn), .Q(
        hsel_prev[1]), .QN(n817) );
  GTECH_FD2 hsel_prev_reg_2_ ( .D(n777), .CP(hclk), .CD(hresetn), .Q(
        hsel_prev[2]), .QN(n816) );
  GTECH_FD2 hsel_prev_reg_3_ ( .D(n778), .CP(hclk), .CD(hresetn), .Q(
        hsel_prev[3]), .QN(n815) );
  GTECH_FD2 hsel_prev_reg_4_ ( .D(n779), .CP(hclk), .CD(hresetn), .Q(
        hsel_prev[4]), .QN(n814) );
  GTECH_FD2 r_ihmaster_data_reg_0_ ( .D(n772), .CP(hclk), .CD(hresetn), .Q(
        hmaster_data[0]), .QN(n773) );
  GTECH_FD2 r_ihmaster_data_reg_1_ ( .D(n770), .CP(hclk), .CD(hresetn), .Q(
        hmaster_data[1]), .QN(n771) );
  GTECH_NOT U812 ( .A(n819), .Z(n780) );
  GTECH_NOR2 U813 ( .A(n820), .B(n821), .Z(n819) );
  GTECH_NOR2 U814 ( .A(n818), .B(hready), .Z(n821) );
  GTECH_NOR2 U815 ( .A(n822), .B(n823), .Z(n820) );
  GTECH_NOT U816 ( .A(hsel[0]), .Z(n823) );
  GTECH_NOT U817 ( .A(n824), .Z(n779) );
  GTECH_NOR2 U818 ( .A(n825), .B(n826), .Z(n824) );
  GTECH_NOR2 U819 ( .A(n814), .B(hready), .Z(n826) );
  GTECH_NOR2 U820 ( .A(n822), .B(n827), .Z(n825) );
  GTECH_NOT U821 ( .A(hsel[4]), .Z(n827) );
  GTECH_NOT U822 ( .A(n828), .Z(n778) );
  GTECH_NOR2 U823 ( .A(n829), .B(n830), .Z(n828) );
  GTECH_NOR2 U824 ( .A(n815), .B(hready), .Z(n830) );
  GTECH_NOR2 U825 ( .A(n822), .B(n831), .Z(n829) );
  GTECH_NOT U826 ( .A(hsel[3]), .Z(n831) );
  GTECH_NOT U827 ( .A(n832), .Z(n777) );
  GTECH_NOR2 U828 ( .A(n833), .B(n834), .Z(n832) );
  GTECH_NOR2 U829 ( .A(n816), .B(hready), .Z(n834) );
  GTECH_NOR2 U830 ( .A(n822), .B(n835), .Z(n833) );
  GTECH_NOT U831 ( .A(hsel[2]), .Z(n835) );
  GTECH_NOT U832 ( .A(n836), .Z(n776) );
  GTECH_NOR2 U833 ( .A(n837), .B(n838), .Z(n836) );
  GTECH_NOR2 U834 ( .A(n817), .B(hready), .Z(n838) );
  GTECH_NOR2 U835 ( .A(n822), .B(n839), .Z(n837) );
  GTECH_NOT U836 ( .A(hsel[1]), .Z(n839) );
  GTECH_NOT U837 ( .A(n840), .Z(n772) );
  GTECH_NOR2 U838 ( .A(n841), .B(n842), .Z(n840) );
  GTECH_NOR2 U839 ( .A(n773), .B(hready), .Z(n842) );
  GTECH_NOR2 U840 ( .A(n822), .B(n843), .Z(n841) );
  GTECH_NOT U841 ( .A(hmaster[0]), .Z(n843) );
  GTECH_NOT U842 ( .A(n844), .Z(n770) );
  GTECH_NOR2 U843 ( .A(n845), .B(n846), .Z(n844) );
  GTECH_NOR2 U844 ( .A(n771), .B(hready), .Z(n846) );
  GTECH_NOR2 U845 ( .A(n822), .B(n847), .Z(n845) );
  GTECH_NOT U846 ( .A(hmaster[1]), .Z(n847) );
  GTECH_NOT U847 ( .A(n848), .Z(hresp[1]) );
  GTECH_NOR2 U848 ( .A(n849), .B(n850), .Z(n848) );
  GTECH_NOR2 U849 ( .A(n814), .B(n851), .Z(n850) );
  GTECH_NOT U850 ( .A(bus_hresp[9]), .Z(n851) );
  GTECH_NOR2 U851 ( .A(n852), .B(n853), .Z(n849) );
  GTECH_NOR2 U852 ( .A(n854), .B(n855), .Z(n853) );
  GTECH_NOR2 U853 ( .A(n815), .B(n856), .Z(n855) );
  GTECH_NOT U854 ( .A(bus_hresp[7]), .Z(n856) );
  GTECH_NOR2 U855 ( .A(n857), .B(n858), .Z(n854) );
  GTECH_NOR2 U856 ( .A(n859), .B(n860), .Z(n858) );
  GTECH_NOR2 U857 ( .A(n816), .B(n861), .Z(n860) );
  GTECH_NOT U858 ( .A(bus_hresp[5]), .Z(n861) );
  GTECH_NOR2 U859 ( .A(n862), .B(n863), .Z(n859) );
  GTECH_NOR2 U860 ( .A(n864), .B(n865), .Z(n863) );
  GTECH_NOR2 U861 ( .A(n817), .B(n866), .Z(n865) );
  GTECH_NOT U862 ( .A(bus_hresp[3]), .Z(n866) );
  GTECH_NOR2 U863 ( .A(n867), .B(n868), .Z(n864) );
  GTECH_NOR2 U864 ( .A(n869), .B(n870), .Z(n868) );
  GTECH_NOR2 U865 ( .A(n818), .B(n871), .Z(n870) );
  GTECH_NOT U866 ( .A(bus_hresp[1]), .Z(n871) );
  GTECH_NOR2 U867 ( .A(n872), .B(n873), .Z(n869) );
  GTECH_NOT U868 ( .A(hresp_none[1]), .Z(n873) );
  GTECH_NOT U869 ( .A(n874), .Z(hresp[0]) );
  GTECH_NOR2 U870 ( .A(n875), .B(n876), .Z(n874) );
  GTECH_NOR2 U871 ( .A(n814), .B(n877), .Z(n876) );
  GTECH_NOT U872 ( .A(bus_hresp[8]), .Z(n877) );
  GTECH_NOR2 U873 ( .A(n852), .B(n878), .Z(n875) );
  GTECH_NOR2 U874 ( .A(n879), .B(n880), .Z(n878) );
  GTECH_NOR2 U875 ( .A(n815), .B(n881), .Z(n880) );
  GTECH_NOT U876 ( .A(bus_hresp[6]), .Z(n881) );
  GTECH_NOR2 U877 ( .A(n857), .B(n882), .Z(n879) );
  GTECH_NOR2 U878 ( .A(n883), .B(n884), .Z(n882) );
  GTECH_NOR2 U879 ( .A(n816), .B(n885), .Z(n884) );
  GTECH_NOT U880 ( .A(bus_hresp[4]), .Z(n885) );
  GTECH_NOR2 U881 ( .A(n862), .B(n886), .Z(n883) );
  GTECH_NOR2 U882 ( .A(n887), .B(n888), .Z(n886) );
  GTECH_NOR2 U883 ( .A(n817), .B(n889), .Z(n888) );
  GTECH_NOT U884 ( .A(bus_hresp[2]), .Z(n889) );
  GTECH_NOR2 U885 ( .A(n867), .B(n890), .Z(n887) );
  GTECH_NOR2 U886 ( .A(n891), .B(n892), .Z(n890) );
  GTECH_NOR2 U887 ( .A(n818), .B(n893), .Z(n892) );
  GTECH_NOT U888 ( .A(bus_hresp[0]), .Z(n893) );
  GTECH_NOR2 U889 ( .A(n872), .B(n894), .Z(n891) );
  GTECH_NOT U890 ( .A(hresp_none[0]), .Z(n894) );
  GTECH_NOT U891 ( .A(n822), .Z(hready) );
  GTECH_NOR2 U892 ( .A(n895), .B(n896), .Z(n822) );
  GTECH_NOR2 U893 ( .A(n814), .B(n897), .Z(n896) );
  GTECH_NOT U894 ( .A(bus_hready[4]), .Z(n897) );
  GTECH_NOR2 U895 ( .A(n852), .B(n898), .Z(n895) );
  GTECH_NOR2 U896 ( .A(n899), .B(n900), .Z(n898) );
  GTECH_NOR2 U897 ( .A(n815), .B(n901), .Z(n900) );
  GTECH_NOT U898 ( .A(bus_hready[3]), .Z(n901) );
  GTECH_NOR2 U899 ( .A(n857), .B(n902), .Z(n899) );
  GTECH_NOR2 U900 ( .A(n903), .B(n904), .Z(n902) );
  GTECH_NOR2 U901 ( .A(n816), .B(n905), .Z(n904) );
  GTECH_NOT U902 ( .A(bus_hready[2]), .Z(n905) );
  GTECH_NOR2 U903 ( .A(n862), .B(n906), .Z(n903) );
  GTECH_NOR2 U904 ( .A(n907), .B(n908), .Z(n906) );
  GTECH_NOR2 U905 ( .A(n817), .B(n909), .Z(n908) );
  GTECH_NOT U906 ( .A(bus_hready[1]), .Z(n909) );
  GTECH_NOR2 U907 ( .A(n867), .B(n910), .Z(n907) );
  GTECH_NOR2 U908 ( .A(n911), .B(n912), .Z(n910) );
  GTECH_NOR2 U909 ( .A(n818), .B(n913), .Z(n912) );
  GTECH_NOT U910 ( .A(bus_hready[0]), .Z(n913) );
  GTECH_NOR2 U911 ( .A(n872), .B(n914), .Z(n911) );
  GTECH_NOT U912 ( .A(hready_resp_none), .Z(n914) );
  GTECH_NOT U913 ( .A(n915), .Z(hrdata[9]) );
  GTECH_NOR2 U914 ( .A(n916), .B(n917), .Z(n915) );
  GTECH_NOR2 U915 ( .A(n814), .B(n918), .Z(n917) );
  GTECH_NOT U916 ( .A(bus_hrdata[137]), .Z(n918) );
  GTECH_NOR2 U917 ( .A(n852), .B(n919), .Z(n916) );
  GTECH_NOR2 U918 ( .A(n920), .B(n921), .Z(n919) );
  GTECH_NOR2 U919 ( .A(n815), .B(n922), .Z(n921) );
  GTECH_NOT U920 ( .A(bus_hrdata[105]), .Z(n922) );
  GTECH_NOR2 U921 ( .A(n857), .B(n923), .Z(n920) );
  GTECH_NOR2 U922 ( .A(n924), .B(n925), .Z(n923) );
  GTECH_NOR2 U923 ( .A(n816), .B(n926), .Z(n925) );
  GTECH_NOT U924 ( .A(bus_hrdata[73]), .Z(n926) );
  GTECH_NOR2 U925 ( .A(n862), .B(n927), .Z(n924) );
  GTECH_NOR2 U926 ( .A(n928), .B(n929), .Z(n927) );
  GTECH_NOR2 U927 ( .A(n817), .B(n930), .Z(n929) );
  GTECH_NOT U928 ( .A(bus_hrdata[41]), .Z(n930) );
  GTECH_NOR2 U929 ( .A(n867), .B(n931), .Z(n928) );
  GTECH_NOR2 U930 ( .A(n932), .B(n933), .Z(n931) );
  GTECH_NOR2 U931 ( .A(n818), .B(n934), .Z(n933) );
  GTECH_NOT U932 ( .A(bus_hrdata[9]), .Z(n934) );
  GTECH_NOR2 U933 ( .A(n872), .B(n935), .Z(n932) );
  GTECH_NOT U934 ( .A(hrdata_none[9]), .Z(n935) );
  GTECH_NOT U935 ( .A(n936), .Z(hrdata[8]) );
  GTECH_NOR2 U936 ( .A(n937), .B(n938), .Z(n936) );
  GTECH_NOR2 U937 ( .A(n814), .B(n939), .Z(n938) );
  GTECH_NOT U938 ( .A(bus_hrdata[136]), .Z(n939) );
  GTECH_NOR2 U939 ( .A(n852), .B(n940), .Z(n937) );
  GTECH_NOR2 U940 ( .A(n941), .B(n942), .Z(n940) );
  GTECH_NOR2 U941 ( .A(n815), .B(n943), .Z(n942) );
  GTECH_NOT U942 ( .A(bus_hrdata[104]), .Z(n943) );
  GTECH_NOR2 U943 ( .A(n857), .B(n944), .Z(n941) );
  GTECH_NOR2 U944 ( .A(n945), .B(n946), .Z(n944) );
  GTECH_NOR2 U945 ( .A(n816), .B(n947), .Z(n946) );
  GTECH_NOT U946 ( .A(bus_hrdata[72]), .Z(n947) );
  GTECH_NOR2 U947 ( .A(n862), .B(n948), .Z(n945) );
  GTECH_NOR2 U948 ( .A(n949), .B(n950), .Z(n948) );
  GTECH_NOR2 U949 ( .A(n817), .B(n951), .Z(n950) );
  GTECH_NOT U950 ( .A(bus_hrdata[40]), .Z(n951) );
  GTECH_NOR2 U951 ( .A(n867), .B(n952), .Z(n949) );
  GTECH_NOR2 U952 ( .A(n953), .B(n954), .Z(n952) );
  GTECH_NOR2 U953 ( .A(n818), .B(n955), .Z(n954) );
  GTECH_NOT U954 ( .A(bus_hrdata[8]), .Z(n955) );
  GTECH_NOR2 U955 ( .A(n872), .B(n956), .Z(n953) );
  GTECH_NOT U956 ( .A(hrdata_none[8]), .Z(n956) );
  GTECH_NOT U957 ( .A(n957), .Z(hrdata[7]) );
  GTECH_NOR2 U958 ( .A(n958), .B(n959), .Z(n957) );
  GTECH_NOR2 U959 ( .A(n814), .B(n960), .Z(n959) );
  GTECH_NOT U960 ( .A(bus_hrdata[135]), .Z(n960) );
  GTECH_NOR2 U961 ( .A(n852), .B(n961), .Z(n958) );
  GTECH_NOR2 U962 ( .A(n962), .B(n963), .Z(n961) );
  GTECH_NOR2 U963 ( .A(n815), .B(n964), .Z(n963) );
  GTECH_NOT U964 ( .A(bus_hrdata[103]), .Z(n964) );
  GTECH_NOR2 U965 ( .A(n857), .B(n965), .Z(n962) );
  GTECH_NOR2 U966 ( .A(n966), .B(n967), .Z(n965) );
  GTECH_NOR2 U967 ( .A(n816), .B(n968), .Z(n967) );
  GTECH_NOT U968 ( .A(bus_hrdata[71]), .Z(n968) );
  GTECH_NOR2 U969 ( .A(n862), .B(n969), .Z(n966) );
  GTECH_NOR2 U970 ( .A(n970), .B(n971), .Z(n969) );
  GTECH_NOR2 U971 ( .A(n817), .B(n972), .Z(n971) );
  GTECH_NOT U972 ( .A(bus_hrdata[39]), .Z(n972) );
  GTECH_NOR2 U973 ( .A(n867), .B(n973), .Z(n970) );
  GTECH_NOR2 U974 ( .A(n974), .B(n975), .Z(n973) );
  GTECH_NOR2 U975 ( .A(n818), .B(n976), .Z(n975) );
  GTECH_NOT U976 ( .A(bus_hrdata[7]), .Z(n976) );
  GTECH_NOR2 U977 ( .A(n872), .B(n977), .Z(n974) );
  GTECH_NOT U978 ( .A(hrdata_none[7]), .Z(n977) );
  GTECH_NOT U979 ( .A(n978), .Z(hrdata[6]) );
  GTECH_NOR2 U980 ( .A(n979), .B(n980), .Z(n978) );
  GTECH_NOR2 U981 ( .A(n814), .B(n981), .Z(n980) );
  GTECH_NOT U982 ( .A(bus_hrdata[134]), .Z(n981) );
  GTECH_NOR2 U983 ( .A(n852), .B(n982), .Z(n979) );
  GTECH_NOR2 U984 ( .A(n983), .B(n984), .Z(n982) );
  GTECH_NOR2 U985 ( .A(n815), .B(n985), .Z(n984) );
  GTECH_NOT U986 ( .A(bus_hrdata[102]), .Z(n985) );
  GTECH_NOR2 U987 ( .A(n857), .B(n986), .Z(n983) );
  GTECH_NOR2 U988 ( .A(n987), .B(n988), .Z(n986) );
  GTECH_NOR2 U989 ( .A(n816), .B(n989), .Z(n988) );
  GTECH_NOT U990 ( .A(bus_hrdata[70]), .Z(n989) );
  GTECH_NOR2 U991 ( .A(n862), .B(n990), .Z(n987) );
  GTECH_NOR2 U992 ( .A(n991), .B(n992), .Z(n990) );
  GTECH_NOR2 U993 ( .A(n817), .B(n993), .Z(n992) );
  GTECH_NOT U994 ( .A(bus_hrdata[38]), .Z(n993) );
  GTECH_NOR2 U995 ( .A(n867), .B(n994), .Z(n991) );
  GTECH_NOR2 U996 ( .A(n995), .B(n996), .Z(n994) );
  GTECH_NOR2 U997 ( .A(n818), .B(n997), .Z(n996) );
  GTECH_NOT U998 ( .A(bus_hrdata[6]), .Z(n997) );
  GTECH_NOR2 U999 ( .A(n872), .B(n998), .Z(n995) );
  GTECH_NOT U1000 ( .A(hrdata_none[6]), .Z(n998) );
  GTECH_NOT U1001 ( .A(n999), .Z(hrdata[5]) );
  GTECH_NOR2 U1002 ( .A(n1000), .B(n1001), .Z(n999) );
  GTECH_NOR2 U1003 ( .A(n814), .B(n1002), .Z(n1001) );
  GTECH_NOT U1004 ( .A(bus_hrdata[133]), .Z(n1002) );
  GTECH_NOR2 U1005 ( .A(n852), .B(n1003), .Z(n1000) );
  GTECH_NOR2 U1006 ( .A(n1004), .B(n1005), .Z(n1003) );
  GTECH_NOR2 U1007 ( .A(n815), .B(n1006), .Z(n1005) );
  GTECH_NOT U1008 ( .A(bus_hrdata[101]), .Z(n1006) );
  GTECH_NOR2 U1009 ( .A(n857), .B(n1007), .Z(n1004) );
  GTECH_NOR2 U1010 ( .A(n1008), .B(n1009), .Z(n1007) );
  GTECH_NOR2 U1011 ( .A(n816), .B(n1010), .Z(n1009) );
  GTECH_NOT U1012 ( .A(bus_hrdata[69]), .Z(n1010) );
  GTECH_NOR2 U1013 ( .A(n862), .B(n1011), .Z(n1008) );
  GTECH_NOR2 U1014 ( .A(n1012), .B(n1013), .Z(n1011) );
  GTECH_NOR2 U1015 ( .A(n817), .B(n1014), .Z(n1013) );
  GTECH_NOT U1016 ( .A(bus_hrdata[37]), .Z(n1014) );
  GTECH_NOR2 U1017 ( .A(n867), .B(n1015), .Z(n1012) );
  GTECH_NOR2 U1018 ( .A(n1016), .B(n1017), .Z(n1015) );
  GTECH_NOR2 U1019 ( .A(n818), .B(n1018), .Z(n1017) );
  GTECH_NOT U1020 ( .A(bus_hrdata[5]), .Z(n1018) );
  GTECH_NOR2 U1021 ( .A(n872), .B(n1019), .Z(n1016) );
  GTECH_NOT U1022 ( .A(hrdata_none[5]), .Z(n1019) );
  GTECH_NOT U1023 ( .A(n1020), .Z(hrdata[4]) );
  GTECH_NOR2 U1024 ( .A(n1021), .B(n1022), .Z(n1020) );
  GTECH_NOR2 U1025 ( .A(n814), .B(n1023), .Z(n1022) );
  GTECH_NOT U1026 ( .A(bus_hrdata[132]), .Z(n1023) );
  GTECH_NOR2 U1027 ( .A(n852), .B(n1024), .Z(n1021) );
  GTECH_NOR2 U1028 ( .A(n1025), .B(n1026), .Z(n1024) );
  GTECH_NOR2 U1029 ( .A(n815), .B(n1027), .Z(n1026) );
  GTECH_NOT U1030 ( .A(bus_hrdata[100]), .Z(n1027) );
  GTECH_NOR2 U1031 ( .A(n857), .B(n1028), .Z(n1025) );
  GTECH_NOR2 U1032 ( .A(n1029), .B(n1030), .Z(n1028) );
  GTECH_NOR2 U1033 ( .A(n816), .B(n1031), .Z(n1030) );
  GTECH_NOT U1034 ( .A(bus_hrdata[68]), .Z(n1031) );
  GTECH_NOR2 U1035 ( .A(n862), .B(n1032), .Z(n1029) );
  GTECH_NOR2 U1036 ( .A(n1033), .B(n1034), .Z(n1032) );
  GTECH_NOR2 U1037 ( .A(n817), .B(n1035), .Z(n1034) );
  GTECH_NOT U1038 ( .A(bus_hrdata[36]), .Z(n1035) );
  GTECH_NOR2 U1039 ( .A(n867), .B(n1036), .Z(n1033) );
  GTECH_NOR2 U1040 ( .A(n1037), .B(n1038), .Z(n1036) );
  GTECH_NOR2 U1041 ( .A(n818), .B(n1039), .Z(n1038) );
  GTECH_NOT U1042 ( .A(bus_hrdata[4]), .Z(n1039) );
  GTECH_NOR2 U1043 ( .A(n872), .B(n1040), .Z(n1037) );
  GTECH_NOT U1044 ( .A(hrdata_none[4]), .Z(n1040) );
  GTECH_NOT U1045 ( .A(n1041), .Z(hrdata[3]) );
  GTECH_NOR2 U1046 ( .A(n1042), .B(n1043), .Z(n1041) );
  GTECH_NOR2 U1047 ( .A(n814), .B(n1044), .Z(n1043) );
  GTECH_NOT U1048 ( .A(bus_hrdata[131]), .Z(n1044) );
  GTECH_NOR2 U1049 ( .A(n852), .B(n1045), .Z(n1042) );
  GTECH_NOR2 U1050 ( .A(n1046), .B(n1047), .Z(n1045) );
  GTECH_NOR2 U1051 ( .A(n815), .B(n1048), .Z(n1047) );
  GTECH_NOT U1052 ( .A(bus_hrdata[99]), .Z(n1048) );
  GTECH_NOR2 U1053 ( .A(n857), .B(n1049), .Z(n1046) );
  GTECH_NOR2 U1054 ( .A(n1050), .B(n1051), .Z(n1049) );
  GTECH_NOR2 U1055 ( .A(n816), .B(n1052), .Z(n1051) );
  GTECH_NOT U1056 ( .A(bus_hrdata[67]), .Z(n1052) );
  GTECH_NOR2 U1057 ( .A(n862), .B(n1053), .Z(n1050) );
  GTECH_NOR2 U1058 ( .A(n1054), .B(n1055), .Z(n1053) );
  GTECH_NOR2 U1059 ( .A(n817), .B(n1056), .Z(n1055) );
  GTECH_NOT U1060 ( .A(bus_hrdata[35]), .Z(n1056) );
  GTECH_NOR2 U1061 ( .A(n867), .B(n1057), .Z(n1054) );
  GTECH_NOR2 U1062 ( .A(n1058), .B(n1059), .Z(n1057) );
  GTECH_NOR2 U1063 ( .A(n818), .B(n1060), .Z(n1059) );
  GTECH_NOT U1064 ( .A(bus_hrdata[3]), .Z(n1060) );
  GTECH_NOR2 U1065 ( .A(n872), .B(n1061), .Z(n1058) );
  GTECH_NOT U1066 ( .A(hrdata_none[3]), .Z(n1061) );
  GTECH_NOT U1067 ( .A(n1062), .Z(hrdata[31]) );
  GTECH_NOR2 U1068 ( .A(n1063), .B(n1064), .Z(n1062) );
  GTECH_NOR2 U1069 ( .A(n814), .B(n1065), .Z(n1064) );
  GTECH_NOT U1070 ( .A(bus_hrdata[159]), .Z(n1065) );
  GTECH_NOR2 U1071 ( .A(n852), .B(n1066), .Z(n1063) );
  GTECH_NOR2 U1072 ( .A(n1067), .B(n1068), .Z(n1066) );
  GTECH_NOR2 U1073 ( .A(n815), .B(n1069), .Z(n1068) );
  GTECH_NOT U1074 ( .A(bus_hrdata[127]), .Z(n1069) );
  GTECH_NOR2 U1075 ( .A(n857), .B(n1070), .Z(n1067) );
  GTECH_NOR2 U1076 ( .A(n1071), .B(n1072), .Z(n1070) );
  GTECH_NOR2 U1077 ( .A(n816), .B(n1073), .Z(n1072) );
  GTECH_NOT U1078 ( .A(bus_hrdata[95]), .Z(n1073) );
  GTECH_NOR2 U1079 ( .A(n862), .B(n1074), .Z(n1071) );
  GTECH_NOR2 U1080 ( .A(n1075), .B(n1076), .Z(n1074) );
  GTECH_NOR2 U1081 ( .A(n817), .B(n1077), .Z(n1076) );
  GTECH_NOT U1082 ( .A(bus_hrdata[63]), .Z(n1077) );
  GTECH_NOR2 U1083 ( .A(n867), .B(n1078), .Z(n1075) );
  GTECH_NOR2 U1084 ( .A(n1079), .B(n1080), .Z(n1078) );
  GTECH_NOR2 U1085 ( .A(n818), .B(n1081), .Z(n1080) );
  GTECH_NOT U1086 ( .A(bus_hrdata[31]), .Z(n1081) );
  GTECH_NOR2 U1087 ( .A(n872), .B(n1082), .Z(n1079) );
  GTECH_NOT U1088 ( .A(hrdata_none[31]), .Z(n1082) );
  GTECH_NOT U1089 ( .A(n1083), .Z(hrdata[30]) );
  GTECH_NOR2 U1090 ( .A(n1084), .B(n1085), .Z(n1083) );
  GTECH_NOR2 U1091 ( .A(n814), .B(n1086), .Z(n1085) );
  GTECH_NOT U1092 ( .A(bus_hrdata[158]), .Z(n1086) );
  GTECH_NOR2 U1093 ( .A(n852), .B(n1087), .Z(n1084) );
  GTECH_NOR2 U1094 ( .A(n1088), .B(n1089), .Z(n1087) );
  GTECH_NOR2 U1095 ( .A(n815), .B(n1090), .Z(n1089) );
  GTECH_NOT U1096 ( .A(bus_hrdata[126]), .Z(n1090) );
  GTECH_NOR2 U1097 ( .A(n857), .B(n1091), .Z(n1088) );
  GTECH_NOR2 U1098 ( .A(n1092), .B(n1093), .Z(n1091) );
  GTECH_NOR2 U1099 ( .A(n816), .B(n1094), .Z(n1093) );
  GTECH_NOT U1100 ( .A(bus_hrdata[94]), .Z(n1094) );
  GTECH_NOR2 U1101 ( .A(n862), .B(n1095), .Z(n1092) );
  GTECH_NOR2 U1102 ( .A(n1096), .B(n1097), .Z(n1095) );
  GTECH_NOR2 U1103 ( .A(n817), .B(n1098), .Z(n1097) );
  GTECH_NOT U1104 ( .A(bus_hrdata[62]), .Z(n1098) );
  GTECH_NOR2 U1105 ( .A(n867), .B(n1099), .Z(n1096) );
  GTECH_NOR2 U1106 ( .A(n1100), .B(n1101), .Z(n1099) );
  GTECH_NOR2 U1107 ( .A(n818), .B(n1102), .Z(n1101) );
  GTECH_NOT U1108 ( .A(bus_hrdata[30]), .Z(n1102) );
  GTECH_NOR2 U1109 ( .A(n872), .B(n1103), .Z(n1100) );
  GTECH_NOT U1110 ( .A(hrdata_none[30]), .Z(n1103) );
  GTECH_NOT U1111 ( .A(n1104), .Z(hrdata[2]) );
  GTECH_NOR2 U1112 ( .A(n1105), .B(n1106), .Z(n1104) );
  GTECH_NOR2 U1113 ( .A(n814), .B(n1107), .Z(n1106) );
  GTECH_NOT U1114 ( .A(bus_hrdata[130]), .Z(n1107) );
  GTECH_NOR2 U1115 ( .A(n852), .B(n1108), .Z(n1105) );
  GTECH_NOR2 U1116 ( .A(n1109), .B(n1110), .Z(n1108) );
  GTECH_NOR2 U1117 ( .A(n815), .B(n1111), .Z(n1110) );
  GTECH_NOT U1118 ( .A(bus_hrdata[98]), .Z(n1111) );
  GTECH_NOR2 U1119 ( .A(n857), .B(n1112), .Z(n1109) );
  GTECH_NOR2 U1120 ( .A(n1113), .B(n1114), .Z(n1112) );
  GTECH_NOR2 U1121 ( .A(n816), .B(n1115), .Z(n1114) );
  GTECH_NOT U1122 ( .A(bus_hrdata[66]), .Z(n1115) );
  GTECH_NOR2 U1123 ( .A(n862), .B(n1116), .Z(n1113) );
  GTECH_NOR2 U1124 ( .A(n1117), .B(n1118), .Z(n1116) );
  GTECH_NOR2 U1125 ( .A(n817), .B(n1119), .Z(n1118) );
  GTECH_NOT U1126 ( .A(bus_hrdata[34]), .Z(n1119) );
  GTECH_NOR2 U1127 ( .A(n867), .B(n1120), .Z(n1117) );
  GTECH_NOR2 U1128 ( .A(n1121), .B(n1122), .Z(n1120) );
  GTECH_NOR2 U1129 ( .A(n818), .B(n1123), .Z(n1122) );
  GTECH_NOT U1130 ( .A(bus_hrdata[2]), .Z(n1123) );
  GTECH_NOR2 U1131 ( .A(n872), .B(n1124), .Z(n1121) );
  GTECH_NOT U1132 ( .A(hrdata_none[2]), .Z(n1124) );
  GTECH_NOT U1133 ( .A(n1125), .Z(hrdata[29]) );
  GTECH_NOR2 U1134 ( .A(n1126), .B(n1127), .Z(n1125) );
  GTECH_NOR2 U1135 ( .A(n814), .B(n1128), .Z(n1127) );
  GTECH_NOT U1136 ( .A(bus_hrdata[157]), .Z(n1128) );
  GTECH_NOR2 U1137 ( .A(n852), .B(n1129), .Z(n1126) );
  GTECH_NOR2 U1138 ( .A(n1130), .B(n1131), .Z(n1129) );
  GTECH_NOR2 U1139 ( .A(n815), .B(n1132), .Z(n1131) );
  GTECH_NOT U1140 ( .A(bus_hrdata[125]), .Z(n1132) );
  GTECH_NOR2 U1141 ( .A(n857), .B(n1133), .Z(n1130) );
  GTECH_NOR2 U1142 ( .A(n1134), .B(n1135), .Z(n1133) );
  GTECH_NOR2 U1143 ( .A(n816), .B(n1136), .Z(n1135) );
  GTECH_NOT U1144 ( .A(bus_hrdata[93]), .Z(n1136) );
  GTECH_NOR2 U1145 ( .A(n862), .B(n1137), .Z(n1134) );
  GTECH_NOR2 U1146 ( .A(n1138), .B(n1139), .Z(n1137) );
  GTECH_NOR2 U1147 ( .A(n817), .B(n1140), .Z(n1139) );
  GTECH_NOT U1148 ( .A(bus_hrdata[61]), .Z(n1140) );
  GTECH_NOR2 U1149 ( .A(n867), .B(n1141), .Z(n1138) );
  GTECH_NOR2 U1150 ( .A(n1142), .B(n1143), .Z(n1141) );
  GTECH_NOR2 U1151 ( .A(n818), .B(n1144), .Z(n1143) );
  GTECH_NOT U1152 ( .A(bus_hrdata[29]), .Z(n1144) );
  GTECH_NOR2 U1153 ( .A(n872), .B(n1145), .Z(n1142) );
  GTECH_NOT U1154 ( .A(hrdata_none[29]), .Z(n1145) );
  GTECH_NOT U1155 ( .A(n1146), .Z(hrdata[28]) );
  GTECH_NOR2 U1156 ( .A(n1147), .B(n1148), .Z(n1146) );
  GTECH_NOR2 U1157 ( .A(n814), .B(n1149), .Z(n1148) );
  GTECH_NOT U1158 ( .A(bus_hrdata[156]), .Z(n1149) );
  GTECH_NOR2 U1159 ( .A(n852), .B(n1150), .Z(n1147) );
  GTECH_NOR2 U1160 ( .A(n1151), .B(n1152), .Z(n1150) );
  GTECH_NOR2 U1161 ( .A(n815), .B(n1153), .Z(n1152) );
  GTECH_NOT U1162 ( .A(bus_hrdata[124]), .Z(n1153) );
  GTECH_NOR2 U1163 ( .A(n857), .B(n1154), .Z(n1151) );
  GTECH_NOR2 U1164 ( .A(n1155), .B(n1156), .Z(n1154) );
  GTECH_NOR2 U1165 ( .A(n816), .B(n1157), .Z(n1156) );
  GTECH_NOT U1166 ( .A(bus_hrdata[92]), .Z(n1157) );
  GTECH_NOR2 U1167 ( .A(n862), .B(n1158), .Z(n1155) );
  GTECH_NOR2 U1168 ( .A(n1159), .B(n1160), .Z(n1158) );
  GTECH_NOR2 U1169 ( .A(n817), .B(n1161), .Z(n1160) );
  GTECH_NOT U1170 ( .A(bus_hrdata[60]), .Z(n1161) );
  GTECH_NOR2 U1171 ( .A(n867), .B(n1162), .Z(n1159) );
  GTECH_NOR2 U1172 ( .A(n1163), .B(n1164), .Z(n1162) );
  GTECH_NOR2 U1173 ( .A(n818), .B(n1165), .Z(n1164) );
  GTECH_NOT U1174 ( .A(bus_hrdata[28]), .Z(n1165) );
  GTECH_NOR2 U1175 ( .A(n872), .B(n1166), .Z(n1163) );
  GTECH_NOT U1176 ( .A(hrdata_none[28]), .Z(n1166) );
  GTECH_NOT U1177 ( .A(n1167), .Z(hrdata[27]) );
  GTECH_NOR2 U1178 ( .A(n1168), .B(n1169), .Z(n1167) );
  GTECH_NOR2 U1179 ( .A(n814), .B(n1170), .Z(n1169) );
  GTECH_NOT U1180 ( .A(bus_hrdata[155]), .Z(n1170) );
  GTECH_NOR2 U1181 ( .A(n852), .B(n1171), .Z(n1168) );
  GTECH_NOR2 U1182 ( .A(n1172), .B(n1173), .Z(n1171) );
  GTECH_NOR2 U1183 ( .A(n815), .B(n1174), .Z(n1173) );
  GTECH_NOT U1184 ( .A(bus_hrdata[123]), .Z(n1174) );
  GTECH_NOR2 U1185 ( .A(n857), .B(n1175), .Z(n1172) );
  GTECH_NOR2 U1186 ( .A(n1176), .B(n1177), .Z(n1175) );
  GTECH_NOR2 U1187 ( .A(n816), .B(n1178), .Z(n1177) );
  GTECH_NOT U1188 ( .A(bus_hrdata[91]), .Z(n1178) );
  GTECH_NOR2 U1189 ( .A(n862), .B(n1179), .Z(n1176) );
  GTECH_NOR2 U1190 ( .A(n1180), .B(n1181), .Z(n1179) );
  GTECH_NOR2 U1191 ( .A(n817), .B(n1182), .Z(n1181) );
  GTECH_NOT U1192 ( .A(bus_hrdata[59]), .Z(n1182) );
  GTECH_NOR2 U1193 ( .A(n867), .B(n1183), .Z(n1180) );
  GTECH_NOR2 U1194 ( .A(n1184), .B(n1185), .Z(n1183) );
  GTECH_NOR2 U1195 ( .A(n818), .B(n1186), .Z(n1185) );
  GTECH_NOT U1196 ( .A(bus_hrdata[27]), .Z(n1186) );
  GTECH_NOR2 U1197 ( .A(n872), .B(n1187), .Z(n1184) );
  GTECH_NOT U1198 ( .A(hrdata_none[27]), .Z(n1187) );
  GTECH_NOT U1199 ( .A(n1188), .Z(hrdata[26]) );
  GTECH_NOR2 U1200 ( .A(n1189), .B(n1190), .Z(n1188) );
  GTECH_NOR2 U1201 ( .A(n814), .B(n1191), .Z(n1190) );
  GTECH_NOT U1202 ( .A(bus_hrdata[154]), .Z(n1191) );
  GTECH_NOR2 U1203 ( .A(n852), .B(n1192), .Z(n1189) );
  GTECH_NOR2 U1204 ( .A(n1193), .B(n1194), .Z(n1192) );
  GTECH_NOR2 U1205 ( .A(n815), .B(n1195), .Z(n1194) );
  GTECH_NOT U1206 ( .A(bus_hrdata[122]), .Z(n1195) );
  GTECH_NOR2 U1207 ( .A(n857), .B(n1196), .Z(n1193) );
  GTECH_NOR2 U1208 ( .A(n1197), .B(n1198), .Z(n1196) );
  GTECH_NOR2 U1209 ( .A(n816), .B(n1199), .Z(n1198) );
  GTECH_NOT U1210 ( .A(bus_hrdata[90]), .Z(n1199) );
  GTECH_NOR2 U1211 ( .A(n862), .B(n1200), .Z(n1197) );
  GTECH_NOR2 U1212 ( .A(n1201), .B(n1202), .Z(n1200) );
  GTECH_NOR2 U1213 ( .A(n817), .B(n1203), .Z(n1202) );
  GTECH_NOT U1214 ( .A(bus_hrdata[58]), .Z(n1203) );
  GTECH_NOR2 U1215 ( .A(n867), .B(n1204), .Z(n1201) );
  GTECH_NOR2 U1216 ( .A(n1205), .B(n1206), .Z(n1204) );
  GTECH_NOR2 U1217 ( .A(n818), .B(n1207), .Z(n1206) );
  GTECH_NOT U1218 ( .A(bus_hrdata[26]), .Z(n1207) );
  GTECH_NOR2 U1219 ( .A(n872), .B(n1208), .Z(n1205) );
  GTECH_NOT U1220 ( .A(hrdata_none[26]), .Z(n1208) );
  GTECH_NOT U1221 ( .A(n1209), .Z(hrdata[25]) );
  GTECH_NOR2 U1222 ( .A(n1210), .B(n1211), .Z(n1209) );
  GTECH_NOR2 U1223 ( .A(n814), .B(n1212), .Z(n1211) );
  GTECH_NOT U1224 ( .A(bus_hrdata[153]), .Z(n1212) );
  GTECH_NOR2 U1225 ( .A(n852), .B(n1213), .Z(n1210) );
  GTECH_NOR2 U1226 ( .A(n1214), .B(n1215), .Z(n1213) );
  GTECH_NOR2 U1227 ( .A(n815), .B(n1216), .Z(n1215) );
  GTECH_NOT U1228 ( .A(bus_hrdata[121]), .Z(n1216) );
  GTECH_NOR2 U1229 ( .A(n857), .B(n1217), .Z(n1214) );
  GTECH_NOR2 U1230 ( .A(n1218), .B(n1219), .Z(n1217) );
  GTECH_NOR2 U1231 ( .A(n816), .B(n1220), .Z(n1219) );
  GTECH_NOT U1232 ( .A(bus_hrdata[89]), .Z(n1220) );
  GTECH_NOR2 U1233 ( .A(n862), .B(n1221), .Z(n1218) );
  GTECH_NOR2 U1234 ( .A(n1222), .B(n1223), .Z(n1221) );
  GTECH_NOR2 U1235 ( .A(n817), .B(n1224), .Z(n1223) );
  GTECH_NOT U1236 ( .A(bus_hrdata[57]), .Z(n1224) );
  GTECH_NOR2 U1237 ( .A(n867), .B(n1225), .Z(n1222) );
  GTECH_NOR2 U1238 ( .A(n1226), .B(n1227), .Z(n1225) );
  GTECH_NOR2 U1239 ( .A(n818), .B(n1228), .Z(n1227) );
  GTECH_NOT U1240 ( .A(bus_hrdata[25]), .Z(n1228) );
  GTECH_NOR2 U1241 ( .A(n872), .B(n1229), .Z(n1226) );
  GTECH_NOT U1242 ( .A(hrdata_none[25]), .Z(n1229) );
  GTECH_NOT U1243 ( .A(n1230), .Z(hrdata[24]) );
  GTECH_NOR2 U1244 ( .A(n1231), .B(n1232), .Z(n1230) );
  GTECH_NOR2 U1245 ( .A(n814), .B(n1233), .Z(n1232) );
  GTECH_NOT U1246 ( .A(bus_hrdata[152]), .Z(n1233) );
  GTECH_NOR2 U1247 ( .A(n852), .B(n1234), .Z(n1231) );
  GTECH_NOR2 U1248 ( .A(n1235), .B(n1236), .Z(n1234) );
  GTECH_NOR2 U1249 ( .A(n815), .B(n1237), .Z(n1236) );
  GTECH_NOT U1250 ( .A(bus_hrdata[120]), .Z(n1237) );
  GTECH_NOR2 U1251 ( .A(n857), .B(n1238), .Z(n1235) );
  GTECH_NOR2 U1252 ( .A(n1239), .B(n1240), .Z(n1238) );
  GTECH_NOR2 U1253 ( .A(n816), .B(n1241), .Z(n1240) );
  GTECH_NOT U1254 ( .A(bus_hrdata[88]), .Z(n1241) );
  GTECH_NOR2 U1255 ( .A(n862), .B(n1242), .Z(n1239) );
  GTECH_NOR2 U1256 ( .A(n1243), .B(n1244), .Z(n1242) );
  GTECH_NOR2 U1257 ( .A(n817), .B(n1245), .Z(n1244) );
  GTECH_NOT U1258 ( .A(bus_hrdata[56]), .Z(n1245) );
  GTECH_NOR2 U1259 ( .A(n867), .B(n1246), .Z(n1243) );
  GTECH_NOR2 U1260 ( .A(n1247), .B(n1248), .Z(n1246) );
  GTECH_NOR2 U1261 ( .A(n818), .B(n1249), .Z(n1248) );
  GTECH_NOT U1262 ( .A(bus_hrdata[24]), .Z(n1249) );
  GTECH_NOR2 U1263 ( .A(n872), .B(n1250), .Z(n1247) );
  GTECH_NOT U1264 ( .A(hrdata_none[24]), .Z(n1250) );
  GTECH_NOT U1265 ( .A(n1251), .Z(hrdata[23]) );
  GTECH_NOR2 U1266 ( .A(n1252), .B(n1253), .Z(n1251) );
  GTECH_NOR2 U1267 ( .A(n814), .B(n1254), .Z(n1253) );
  GTECH_NOT U1268 ( .A(bus_hrdata[151]), .Z(n1254) );
  GTECH_NOR2 U1269 ( .A(n852), .B(n1255), .Z(n1252) );
  GTECH_NOR2 U1270 ( .A(n1256), .B(n1257), .Z(n1255) );
  GTECH_NOR2 U1271 ( .A(n815), .B(n1258), .Z(n1257) );
  GTECH_NOT U1272 ( .A(bus_hrdata[119]), .Z(n1258) );
  GTECH_NOR2 U1273 ( .A(n857), .B(n1259), .Z(n1256) );
  GTECH_NOR2 U1274 ( .A(n1260), .B(n1261), .Z(n1259) );
  GTECH_NOR2 U1275 ( .A(n816), .B(n1262), .Z(n1261) );
  GTECH_NOT U1276 ( .A(bus_hrdata[87]), .Z(n1262) );
  GTECH_NOR2 U1277 ( .A(n862), .B(n1263), .Z(n1260) );
  GTECH_NOR2 U1278 ( .A(n1264), .B(n1265), .Z(n1263) );
  GTECH_NOR2 U1279 ( .A(n817), .B(n1266), .Z(n1265) );
  GTECH_NOT U1280 ( .A(bus_hrdata[55]), .Z(n1266) );
  GTECH_NOR2 U1281 ( .A(n867), .B(n1267), .Z(n1264) );
  GTECH_NOR2 U1282 ( .A(n1268), .B(n1269), .Z(n1267) );
  GTECH_NOR2 U1283 ( .A(n818), .B(n1270), .Z(n1269) );
  GTECH_NOT U1284 ( .A(bus_hrdata[23]), .Z(n1270) );
  GTECH_NOR2 U1285 ( .A(n872), .B(n1271), .Z(n1268) );
  GTECH_NOT U1286 ( .A(hrdata_none[23]), .Z(n1271) );
  GTECH_NOT U1287 ( .A(n1272), .Z(hrdata[22]) );
  GTECH_NOR2 U1288 ( .A(n1273), .B(n1274), .Z(n1272) );
  GTECH_NOR2 U1289 ( .A(n814), .B(n1275), .Z(n1274) );
  GTECH_NOT U1290 ( .A(bus_hrdata[150]), .Z(n1275) );
  GTECH_NOR2 U1291 ( .A(n852), .B(n1276), .Z(n1273) );
  GTECH_NOR2 U1292 ( .A(n1277), .B(n1278), .Z(n1276) );
  GTECH_NOR2 U1293 ( .A(n815), .B(n1279), .Z(n1278) );
  GTECH_NOT U1294 ( .A(bus_hrdata[118]), .Z(n1279) );
  GTECH_NOR2 U1295 ( .A(n857), .B(n1280), .Z(n1277) );
  GTECH_NOR2 U1296 ( .A(n1281), .B(n1282), .Z(n1280) );
  GTECH_NOR2 U1297 ( .A(n816), .B(n1283), .Z(n1282) );
  GTECH_NOT U1298 ( .A(bus_hrdata[86]), .Z(n1283) );
  GTECH_NOR2 U1299 ( .A(n862), .B(n1284), .Z(n1281) );
  GTECH_NOR2 U1300 ( .A(n1285), .B(n1286), .Z(n1284) );
  GTECH_NOR2 U1301 ( .A(n817), .B(n1287), .Z(n1286) );
  GTECH_NOT U1302 ( .A(bus_hrdata[54]), .Z(n1287) );
  GTECH_NOR2 U1303 ( .A(n867), .B(n1288), .Z(n1285) );
  GTECH_NOR2 U1304 ( .A(n1289), .B(n1290), .Z(n1288) );
  GTECH_NOR2 U1305 ( .A(n818), .B(n1291), .Z(n1290) );
  GTECH_NOT U1306 ( .A(bus_hrdata[22]), .Z(n1291) );
  GTECH_NOR2 U1307 ( .A(n872), .B(n1292), .Z(n1289) );
  GTECH_NOT U1308 ( .A(hrdata_none[22]), .Z(n1292) );
  GTECH_NOT U1309 ( .A(n1293), .Z(hrdata[21]) );
  GTECH_NOR2 U1310 ( .A(n1294), .B(n1295), .Z(n1293) );
  GTECH_NOR2 U1311 ( .A(n814), .B(n1296), .Z(n1295) );
  GTECH_NOT U1312 ( .A(bus_hrdata[149]), .Z(n1296) );
  GTECH_NOR2 U1313 ( .A(n852), .B(n1297), .Z(n1294) );
  GTECH_NOR2 U1314 ( .A(n1298), .B(n1299), .Z(n1297) );
  GTECH_NOR2 U1315 ( .A(n815), .B(n1300), .Z(n1299) );
  GTECH_NOT U1316 ( .A(bus_hrdata[117]), .Z(n1300) );
  GTECH_NOR2 U1317 ( .A(n857), .B(n1301), .Z(n1298) );
  GTECH_NOR2 U1318 ( .A(n1302), .B(n1303), .Z(n1301) );
  GTECH_NOR2 U1319 ( .A(n816), .B(n1304), .Z(n1303) );
  GTECH_NOT U1320 ( .A(bus_hrdata[85]), .Z(n1304) );
  GTECH_NOR2 U1321 ( .A(n862), .B(n1305), .Z(n1302) );
  GTECH_NOR2 U1322 ( .A(n1306), .B(n1307), .Z(n1305) );
  GTECH_NOR2 U1323 ( .A(n817), .B(n1308), .Z(n1307) );
  GTECH_NOT U1324 ( .A(bus_hrdata[53]), .Z(n1308) );
  GTECH_NOR2 U1325 ( .A(n867), .B(n1309), .Z(n1306) );
  GTECH_NOR2 U1326 ( .A(n1310), .B(n1311), .Z(n1309) );
  GTECH_NOR2 U1327 ( .A(n818), .B(n1312), .Z(n1311) );
  GTECH_NOT U1328 ( .A(bus_hrdata[21]), .Z(n1312) );
  GTECH_NOR2 U1329 ( .A(n872), .B(n1313), .Z(n1310) );
  GTECH_NOT U1330 ( .A(hrdata_none[21]), .Z(n1313) );
  GTECH_NOT U1331 ( .A(n1314), .Z(hrdata[20]) );
  GTECH_NOR2 U1332 ( .A(n1315), .B(n1316), .Z(n1314) );
  GTECH_NOR2 U1333 ( .A(n814), .B(n1317), .Z(n1316) );
  GTECH_NOT U1334 ( .A(bus_hrdata[148]), .Z(n1317) );
  GTECH_NOR2 U1335 ( .A(n852), .B(n1318), .Z(n1315) );
  GTECH_NOR2 U1336 ( .A(n1319), .B(n1320), .Z(n1318) );
  GTECH_NOR2 U1337 ( .A(n815), .B(n1321), .Z(n1320) );
  GTECH_NOT U1338 ( .A(bus_hrdata[116]), .Z(n1321) );
  GTECH_NOR2 U1339 ( .A(n857), .B(n1322), .Z(n1319) );
  GTECH_NOR2 U1340 ( .A(n1323), .B(n1324), .Z(n1322) );
  GTECH_NOR2 U1341 ( .A(n816), .B(n1325), .Z(n1324) );
  GTECH_NOT U1342 ( .A(bus_hrdata[84]), .Z(n1325) );
  GTECH_NOR2 U1343 ( .A(n862), .B(n1326), .Z(n1323) );
  GTECH_NOR2 U1344 ( .A(n1327), .B(n1328), .Z(n1326) );
  GTECH_NOR2 U1345 ( .A(n817), .B(n1329), .Z(n1328) );
  GTECH_NOT U1346 ( .A(bus_hrdata[52]), .Z(n1329) );
  GTECH_NOR2 U1347 ( .A(n867), .B(n1330), .Z(n1327) );
  GTECH_NOR2 U1348 ( .A(n1331), .B(n1332), .Z(n1330) );
  GTECH_NOR2 U1349 ( .A(n818), .B(n1333), .Z(n1332) );
  GTECH_NOT U1350 ( .A(bus_hrdata[20]), .Z(n1333) );
  GTECH_NOR2 U1351 ( .A(n872), .B(n1334), .Z(n1331) );
  GTECH_NOT U1352 ( .A(hrdata_none[20]), .Z(n1334) );
  GTECH_NOT U1353 ( .A(n1335), .Z(hrdata[1]) );
  GTECH_NOR2 U1354 ( .A(n1336), .B(n1337), .Z(n1335) );
  GTECH_NOR2 U1355 ( .A(n814), .B(n1338), .Z(n1337) );
  GTECH_NOT U1356 ( .A(bus_hrdata[129]), .Z(n1338) );
  GTECH_NOR2 U1357 ( .A(n852), .B(n1339), .Z(n1336) );
  GTECH_NOR2 U1358 ( .A(n1340), .B(n1341), .Z(n1339) );
  GTECH_NOR2 U1359 ( .A(n815), .B(n1342), .Z(n1341) );
  GTECH_NOT U1360 ( .A(bus_hrdata[97]), .Z(n1342) );
  GTECH_NOR2 U1361 ( .A(n857), .B(n1343), .Z(n1340) );
  GTECH_NOR2 U1362 ( .A(n1344), .B(n1345), .Z(n1343) );
  GTECH_NOR2 U1363 ( .A(n816), .B(n1346), .Z(n1345) );
  GTECH_NOT U1364 ( .A(bus_hrdata[65]), .Z(n1346) );
  GTECH_NOR2 U1365 ( .A(n862), .B(n1347), .Z(n1344) );
  GTECH_NOR2 U1366 ( .A(n1348), .B(n1349), .Z(n1347) );
  GTECH_NOR2 U1367 ( .A(n817), .B(n1350), .Z(n1349) );
  GTECH_NOT U1368 ( .A(bus_hrdata[33]), .Z(n1350) );
  GTECH_NOR2 U1369 ( .A(n867), .B(n1351), .Z(n1348) );
  GTECH_NOR2 U1370 ( .A(n1352), .B(n1353), .Z(n1351) );
  GTECH_NOR2 U1371 ( .A(n818), .B(n1354), .Z(n1353) );
  GTECH_NOT U1372 ( .A(bus_hrdata[1]), .Z(n1354) );
  GTECH_NOR2 U1373 ( .A(n872), .B(n1355), .Z(n1352) );
  GTECH_NOT U1374 ( .A(hrdata_none[1]), .Z(n1355) );
  GTECH_NOT U1375 ( .A(n1356), .Z(hrdata[19]) );
  GTECH_NOR2 U1376 ( .A(n1357), .B(n1358), .Z(n1356) );
  GTECH_NOR2 U1377 ( .A(n814), .B(n1359), .Z(n1358) );
  GTECH_NOT U1378 ( .A(bus_hrdata[147]), .Z(n1359) );
  GTECH_NOR2 U1379 ( .A(n852), .B(n1360), .Z(n1357) );
  GTECH_NOR2 U1380 ( .A(n1361), .B(n1362), .Z(n1360) );
  GTECH_NOR2 U1381 ( .A(n815), .B(n1363), .Z(n1362) );
  GTECH_NOT U1382 ( .A(bus_hrdata[115]), .Z(n1363) );
  GTECH_NOR2 U1383 ( .A(n857), .B(n1364), .Z(n1361) );
  GTECH_NOR2 U1384 ( .A(n1365), .B(n1366), .Z(n1364) );
  GTECH_NOR2 U1385 ( .A(n816), .B(n1367), .Z(n1366) );
  GTECH_NOT U1386 ( .A(bus_hrdata[83]), .Z(n1367) );
  GTECH_NOR2 U1387 ( .A(n862), .B(n1368), .Z(n1365) );
  GTECH_NOR2 U1388 ( .A(n1369), .B(n1370), .Z(n1368) );
  GTECH_NOR2 U1389 ( .A(n817), .B(n1371), .Z(n1370) );
  GTECH_NOT U1390 ( .A(bus_hrdata[51]), .Z(n1371) );
  GTECH_NOR2 U1391 ( .A(n867), .B(n1372), .Z(n1369) );
  GTECH_NOR2 U1392 ( .A(n1373), .B(n1374), .Z(n1372) );
  GTECH_NOR2 U1393 ( .A(n818), .B(n1375), .Z(n1374) );
  GTECH_NOT U1394 ( .A(bus_hrdata[19]), .Z(n1375) );
  GTECH_NOR2 U1395 ( .A(n872), .B(n1376), .Z(n1373) );
  GTECH_NOT U1396 ( .A(hrdata_none[19]), .Z(n1376) );
  GTECH_NOT U1397 ( .A(n1377), .Z(hrdata[18]) );
  GTECH_NOR2 U1398 ( .A(n1378), .B(n1379), .Z(n1377) );
  GTECH_NOR2 U1399 ( .A(n814), .B(n1380), .Z(n1379) );
  GTECH_NOT U1400 ( .A(bus_hrdata[146]), .Z(n1380) );
  GTECH_NOR2 U1401 ( .A(n852), .B(n1381), .Z(n1378) );
  GTECH_NOR2 U1402 ( .A(n1382), .B(n1383), .Z(n1381) );
  GTECH_NOR2 U1403 ( .A(n815), .B(n1384), .Z(n1383) );
  GTECH_NOT U1404 ( .A(bus_hrdata[114]), .Z(n1384) );
  GTECH_NOR2 U1405 ( .A(n857), .B(n1385), .Z(n1382) );
  GTECH_NOR2 U1406 ( .A(n1386), .B(n1387), .Z(n1385) );
  GTECH_NOR2 U1407 ( .A(n816), .B(n1388), .Z(n1387) );
  GTECH_NOT U1408 ( .A(bus_hrdata[82]), .Z(n1388) );
  GTECH_NOR2 U1409 ( .A(n862), .B(n1389), .Z(n1386) );
  GTECH_NOR2 U1410 ( .A(n1390), .B(n1391), .Z(n1389) );
  GTECH_NOR2 U1411 ( .A(n817), .B(n1392), .Z(n1391) );
  GTECH_NOT U1412 ( .A(bus_hrdata[50]), .Z(n1392) );
  GTECH_NOR2 U1413 ( .A(n867), .B(n1393), .Z(n1390) );
  GTECH_NOR2 U1414 ( .A(n1394), .B(n1395), .Z(n1393) );
  GTECH_NOR2 U1415 ( .A(n818), .B(n1396), .Z(n1395) );
  GTECH_NOT U1416 ( .A(bus_hrdata[18]), .Z(n1396) );
  GTECH_NOR2 U1417 ( .A(n872), .B(n1397), .Z(n1394) );
  GTECH_NOT U1418 ( .A(hrdata_none[18]), .Z(n1397) );
  GTECH_NOT U1419 ( .A(n1398), .Z(hrdata[17]) );
  GTECH_NOR2 U1420 ( .A(n1399), .B(n1400), .Z(n1398) );
  GTECH_NOR2 U1421 ( .A(n814), .B(n1401), .Z(n1400) );
  GTECH_NOT U1422 ( .A(bus_hrdata[145]), .Z(n1401) );
  GTECH_NOR2 U1423 ( .A(n852), .B(n1402), .Z(n1399) );
  GTECH_NOR2 U1424 ( .A(n1403), .B(n1404), .Z(n1402) );
  GTECH_NOR2 U1425 ( .A(n815), .B(n1405), .Z(n1404) );
  GTECH_NOT U1426 ( .A(bus_hrdata[113]), .Z(n1405) );
  GTECH_NOR2 U1427 ( .A(n857), .B(n1406), .Z(n1403) );
  GTECH_NOR2 U1428 ( .A(n1407), .B(n1408), .Z(n1406) );
  GTECH_NOR2 U1429 ( .A(n816), .B(n1409), .Z(n1408) );
  GTECH_NOT U1430 ( .A(bus_hrdata[81]), .Z(n1409) );
  GTECH_NOR2 U1431 ( .A(n862), .B(n1410), .Z(n1407) );
  GTECH_NOR2 U1432 ( .A(n1411), .B(n1412), .Z(n1410) );
  GTECH_NOR2 U1433 ( .A(n817), .B(n1413), .Z(n1412) );
  GTECH_NOT U1434 ( .A(bus_hrdata[49]), .Z(n1413) );
  GTECH_NOR2 U1435 ( .A(n867), .B(n1414), .Z(n1411) );
  GTECH_NOR2 U1436 ( .A(n1415), .B(n1416), .Z(n1414) );
  GTECH_NOR2 U1437 ( .A(n818), .B(n1417), .Z(n1416) );
  GTECH_NOT U1438 ( .A(bus_hrdata[17]), .Z(n1417) );
  GTECH_NOR2 U1439 ( .A(n872), .B(n1418), .Z(n1415) );
  GTECH_NOT U1440 ( .A(hrdata_none[17]), .Z(n1418) );
  GTECH_NOT U1441 ( .A(n1419), .Z(hrdata[16]) );
  GTECH_NOR2 U1442 ( .A(n1420), .B(n1421), .Z(n1419) );
  GTECH_NOR2 U1443 ( .A(n814), .B(n1422), .Z(n1421) );
  GTECH_NOT U1444 ( .A(bus_hrdata[144]), .Z(n1422) );
  GTECH_NOR2 U1445 ( .A(n852), .B(n1423), .Z(n1420) );
  GTECH_NOR2 U1446 ( .A(n1424), .B(n1425), .Z(n1423) );
  GTECH_NOR2 U1447 ( .A(n815), .B(n1426), .Z(n1425) );
  GTECH_NOT U1448 ( .A(bus_hrdata[112]), .Z(n1426) );
  GTECH_NOR2 U1449 ( .A(n857), .B(n1427), .Z(n1424) );
  GTECH_NOR2 U1450 ( .A(n1428), .B(n1429), .Z(n1427) );
  GTECH_NOR2 U1451 ( .A(n816), .B(n1430), .Z(n1429) );
  GTECH_NOT U1452 ( .A(bus_hrdata[80]), .Z(n1430) );
  GTECH_NOR2 U1453 ( .A(n862), .B(n1431), .Z(n1428) );
  GTECH_NOR2 U1454 ( .A(n1432), .B(n1433), .Z(n1431) );
  GTECH_NOR2 U1455 ( .A(n817), .B(n1434), .Z(n1433) );
  GTECH_NOT U1456 ( .A(bus_hrdata[48]), .Z(n1434) );
  GTECH_NOR2 U1457 ( .A(n867), .B(n1435), .Z(n1432) );
  GTECH_NOR2 U1458 ( .A(n1436), .B(n1437), .Z(n1435) );
  GTECH_NOR2 U1459 ( .A(n818), .B(n1438), .Z(n1437) );
  GTECH_NOT U1460 ( .A(bus_hrdata[16]), .Z(n1438) );
  GTECH_NOR2 U1461 ( .A(n872), .B(n1439), .Z(n1436) );
  GTECH_NOT U1462 ( .A(hrdata_none[16]), .Z(n1439) );
  GTECH_NOT U1463 ( .A(n1440), .Z(hrdata[15]) );
  GTECH_NOR2 U1464 ( .A(n1441), .B(n1442), .Z(n1440) );
  GTECH_NOR2 U1465 ( .A(n814), .B(n1443), .Z(n1442) );
  GTECH_NOT U1466 ( .A(bus_hrdata[143]), .Z(n1443) );
  GTECH_NOR2 U1467 ( .A(n852), .B(n1444), .Z(n1441) );
  GTECH_NOR2 U1468 ( .A(n1445), .B(n1446), .Z(n1444) );
  GTECH_NOR2 U1469 ( .A(n815), .B(n1447), .Z(n1446) );
  GTECH_NOT U1470 ( .A(bus_hrdata[111]), .Z(n1447) );
  GTECH_NOR2 U1471 ( .A(n857), .B(n1448), .Z(n1445) );
  GTECH_NOR2 U1472 ( .A(n1449), .B(n1450), .Z(n1448) );
  GTECH_NOR2 U1473 ( .A(n816), .B(n1451), .Z(n1450) );
  GTECH_NOT U1474 ( .A(bus_hrdata[79]), .Z(n1451) );
  GTECH_NOR2 U1475 ( .A(n862), .B(n1452), .Z(n1449) );
  GTECH_NOR2 U1476 ( .A(n1453), .B(n1454), .Z(n1452) );
  GTECH_NOR2 U1477 ( .A(n817), .B(n1455), .Z(n1454) );
  GTECH_NOT U1478 ( .A(bus_hrdata[47]), .Z(n1455) );
  GTECH_NOR2 U1479 ( .A(n867), .B(n1456), .Z(n1453) );
  GTECH_NOR2 U1480 ( .A(n1457), .B(n1458), .Z(n1456) );
  GTECH_NOR2 U1481 ( .A(n818), .B(n1459), .Z(n1458) );
  GTECH_NOT U1482 ( .A(bus_hrdata[15]), .Z(n1459) );
  GTECH_NOR2 U1483 ( .A(n872), .B(n1460), .Z(n1457) );
  GTECH_NOT U1484 ( .A(hrdata_none[15]), .Z(n1460) );
  GTECH_NOT U1485 ( .A(n1461), .Z(hrdata[14]) );
  GTECH_NOR2 U1486 ( .A(n1462), .B(n1463), .Z(n1461) );
  GTECH_NOR2 U1487 ( .A(n814), .B(n1464), .Z(n1463) );
  GTECH_NOT U1488 ( .A(bus_hrdata[142]), .Z(n1464) );
  GTECH_NOR2 U1489 ( .A(n852), .B(n1465), .Z(n1462) );
  GTECH_NOR2 U1490 ( .A(n1466), .B(n1467), .Z(n1465) );
  GTECH_NOR2 U1491 ( .A(n815), .B(n1468), .Z(n1467) );
  GTECH_NOT U1492 ( .A(bus_hrdata[110]), .Z(n1468) );
  GTECH_NOR2 U1493 ( .A(n857), .B(n1469), .Z(n1466) );
  GTECH_NOR2 U1494 ( .A(n1470), .B(n1471), .Z(n1469) );
  GTECH_NOR2 U1495 ( .A(n816), .B(n1472), .Z(n1471) );
  GTECH_NOT U1496 ( .A(bus_hrdata[78]), .Z(n1472) );
  GTECH_NOR2 U1497 ( .A(n862), .B(n1473), .Z(n1470) );
  GTECH_NOR2 U1498 ( .A(n1474), .B(n1475), .Z(n1473) );
  GTECH_NOR2 U1499 ( .A(n817), .B(n1476), .Z(n1475) );
  GTECH_NOT U1500 ( .A(bus_hrdata[46]), .Z(n1476) );
  GTECH_NOR2 U1501 ( .A(n867), .B(n1477), .Z(n1474) );
  GTECH_NOR2 U1502 ( .A(n1478), .B(n1479), .Z(n1477) );
  GTECH_NOR2 U1503 ( .A(n818), .B(n1480), .Z(n1479) );
  GTECH_NOT U1504 ( .A(bus_hrdata[14]), .Z(n1480) );
  GTECH_NOR2 U1505 ( .A(n872), .B(n1481), .Z(n1478) );
  GTECH_NOT U1506 ( .A(hrdata_none[14]), .Z(n1481) );
  GTECH_NOT U1507 ( .A(n1482), .Z(hrdata[13]) );
  GTECH_NOR2 U1508 ( .A(n1483), .B(n1484), .Z(n1482) );
  GTECH_NOR2 U1509 ( .A(n814), .B(n1485), .Z(n1484) );
  GTECH_NOT U1510 ( .A(bus_hrdata[141]), .Z(n1485) );
  GTECH_NOR2 U1511 ( .A(n852), .B(n1486), .Z(n1483) );
  GTECH_NOR2 U1512 ( .A(n1487), .B(n1488), .Z(n1486) );
  GTECH_NOR2 U1513 ( .A(n815), .B(n1489), .Z(n1488) );
  GTECH_NOT U1514 ( .A(bus_hrdata[109]), .Z(n1489) );
  GTECH_NOR2 U1515 ( .A(n857), .B(n1490), .Z(n1487) );
  GTECH_NOR2 U1516 ( .A(n1491), .B(n1492), .Z(n1490) );
  GTECH_NOR2 U1517 ( .A(n816), .B(n1493), .Z(n1492) );
  GTECH_NOT U1518 ( .A(bus_hrdata[77]), .Z(n1493) );
  GTECH_NOR2 U1519 ( .A(n862), .B(n1494), .Z(n1491) );
  GTECH_NOR2 U1520 ( .A(n1495), .B(n1496), .Z(n1494) );
  GTECH_NOR2 U1521 ( .A(n817), .B(n1497), .Z(n1496) );
  GTECH_NOT U1522 ( .A(bus_hrdata[45]), .Z(n1497) );
  GTECH_NOR2 U1523 ( .A(n867), .B(n1498), .Z(n1495) );
  GTECH_NOR2 U1524 ( .A(n1499), .B(n1500), .Z(n1498) );
  GTECH_NOR2 U1525 ( .A(n818), .B(n1501), .Z(n1500) );
  GTECH_NOT U1526 ( .A(bus_hrdata[13]), .Z(n1501) );
  GTECH_NOR2 U1527 ( .A(n872), .B(n1502), .Z(n1499) );
  GTECH_NOT U1528 ( .A(hrdata_none[13]), .Z(n1502) );
  GTECH_NOT U1529 ( .A(n1503), .Z(hrdata[12]) );
  GTECH_NOR2 U1530 ( .A(n1504), .B(n1505), .Z(n1503) );
  GTECH_NOR2 U1531 ( .A(n814), .B(n1506), .Z(n1505) );
  GTECH_NOT U1532 ( .A(bus_hrdata[140]), .Z(n1506) );
  GTECH_NOR2 U1533 ( .A(n852), .B(n1507), .Z(n1504) );
  GTECH_NOR2 U1534 ( .A(n1508), .B(n1509), .Z(n1507) );
  GTECH_NOR2 U1535 ( .A(n815), .B(n1510), .Z(n1509) );
  GTECH_NOT U1536 ( .A(bus_hrdata[108]), .Z(n1510) );
  GTECH_NOR2 U1537 ( .A(n857), .B(n1511), .Z(n1508) );
  GTECH_NOR2 U1538 ( .A(n1512), .B(n1513), .Z(n1511) );
  GTECH_NOR2 U1539 ( .A(n816), .B(n1514), .Z(n1513) );
  GTECH_NOT U1540 ( .A(bus_hrdata[76]), .Z(n1514) );
  GTECH_NOR2 U1541 ( .A(n862), .B(n1515), .Z(n1512) );
  GTECH_NOR2 U1542 ( .A(n1516), .B(n1517), .Z(n1515) );
  GTECH_NOR2 U1543 ( .A(n817), .B(n1518), .Z(n1517) );
  GTECH_NOT U1544 ( .A(bus_hrdata[44]), .Z(n1518) );
  GTECH_NOR2 U1545 ( .A(n867), .B(n1519), .Z(n1516) );
  GTECH_NOR2 U1546 ( .A(n1520), .B(n1521), .Z(n1519) );
  GTECH_NOR2 U1547 ( .A(n818), .B(n1522), .Z(n1521) );
  GTECH_NOT U1548 ( .A(bus_hrdata[12]), .Z(n1522) );
  GTECH_NOR2 U1549 ( .A(n872), .B(n1523), .Z(n1520) );
  GTECH_NOT U1550 ( .A(hrdata_none[12]), .Z(n1523) );
  GTECH_NOT U1551 ( .A(n1524), .Z(hrdata[11]) );
  GTECH_NOR2 U1552 ( .A(n1525), .B(n1526), .Z(n1524) );
  GTECH_NOR2 U1553 ( .A(n814), .B(n1527), .Z(n1526) );
  GTECH_NOT U1554 ( .A(bus_hrdata[139]), .Z(n1527) );
  GTECH_NOR2 U1555 ( .A(n852), .B(n1528), .Z(n1525) );
  GTECH_NOR2 U1556 ( .A(n1529), .B(n1530), .Z(n1528) );
  GTECH_NOR2 U1557 ( .A(n815), .B(n1531), .Z(n1530) );
  GTECH_NOT U1558 ( .A(bus_hrdata[107]), .Z(n1531) );
  GTECH_NOR2 U1559 ( .A(n857), .B(n1532), .Z(n1529) );
  GTECH_NOR2 U1560 ( .A(n1533), .B(n1534), .Z(n1532) );
  GTECH_NOR2 U1561 ( .A(n816), .B(n1535), .Z(n1534) );
  GTECH_NOT U1562 ( .A(bus_hrdata[75]), .Z(n1535) );
  GTECH_NOR2 U1563 ( .A(n862), .B(n1536), .Z(n1533) );
  GTECH_NOR2 U1564 ( .A(n1537), .B(n1538), .Z(n1536) );
  GTECH_NOR2 U1565 ( .A(n817), .B(n1539), .Z(n1538) );
  GTECH_NOT U1566 ( .A(bus_hrdata[43]), .Z(n1539) );
  GTECH_NOR2 U1567 ( .A(n867), .B(n1540), .Z(n1537) );
  GTECH_NOR2 U1568 ( .A(n1541), .B(n1542), .Z(n1540) );
  GTECH_NOR2 U1569 ( .A(n818), .B(n1543), .Z(n1542) );
  GTECH_NOT U1570 ( .A(bus_hrdata[11]), .Z(n1543) );
  GTECH_NOR2 U1571 ( .A(n872), .B(n1544), .Z(n1541) );
  GTECH_NOT U1572 ( .A(hrdata_none[11]), .Z(n1544) );
  GTECH_NOT U1573 ( .A(n1545), .Z(hrdata[10]) );
  GTECH_NOR2 U1574 ( .A(n1546), .B(n1547), .Z(n1545) );
  GTECH_NOR2 U1575 ( .A(n814), .B(n1548), .Z(n1547) );
  GTECH_NOT U1576 ( .A(bus_hrdata[138]), .Z(n1548) );
  GTECH_NOR2 U1577 ( .A(n852), .B(n1549), .Z(n1546) );
  GTECH_NOR2 U1578 ( .A(n1550), .B(n1551), .Z(n1549) );
  GTECH_NOR2 U1579 ( .A(n815), .B(n1552), .Z(n1551) );
  GTECH_NOT U1580 ( .A(bus_hrdata[106]), .Z(n1552) );
  GTECH_NOR2 U1581 ( .A(n857), .B(n1553), .Z(n1550) );
  GTECH_NOR2 U1582 ( .A(n1554), .B(n1555), .Z(n1553) );
  GTECH_NOR2 U1583 ( .A(n816), .B(n1556), .Z(n1555) );
  GTECH_NOT U1584 ( .A(bus_hrdata[74]), .Z(n1556) );
  GTECH_NOR2 U1585 ( .A(n862), .B(n1557), .Z(n1554) );
  GTECH_NOR2 U1586 ( .A(n1558), .B(n1559), .Z(n1557) );
  GTECH_NOR2 U1587 ( .A(n817), .B(n1560), .Z(n1559) );
  GTECH_NOT U1588 ( .A(bus_hrdata[42]), .Z(n1560) );
  GTECH_NOR2 U1589 ( .A(n867), .B(n1561), .Z(n1558) );
  GTECH_NOR2 U1590 ( .A(n1562), .B(n1563), .Z(n1561) );
  GTECH_NOR2 U1591 ( .A(n818), .B(n1564), .Z(n1563) );
  GTECH_NOT U1592 ( .A(bus_hrdata[10]), .Z(n1564) );
  GTECH_NOR2 U1593 ( .A(n872), .B(n1565), .Z(n1562) );
  GTECH_NOT U1594 ( .A(hrdata_none[10]), .Z(n1565) );
  GTECH_NOT U1595 ( .A(n1566), .Z(hrdata[0]) );
  GTECH_NOR2 U1596 ( .A(n1567), .B(n1568), .Z(n1566) );
  GTECH_NOR2 U1597 ( .A(n814), .B(n1569), .Z(n1568) );
  GTECH_NOT U1598 ( .A(bus_hrdata[128]), .Z(n1569) );
  GTECH_NOR2 U1599 ( .A(n852), .B(n1570), .Z(n1567) );
  GTECH_NOR2 U1600 ( .A(n1571), .B(n1572), .Z(n1570) );
  GTECH_NOR2 U1601 ( .A(n815), .B(n1573), .Z(n1572) );
  GTECH_NOT U1602 ( .A(bus_hrdata[96]), .Z(n1573) );
  GTECH_NOR2 U1603 ( .A(n857), .B(n1574), .Z(n1571) );
  GTECH_NOR2 U1604 ( .A(n1575), .B(n1576), .Z(n1574) );
  GTECH_NOR2 U1605 ( .A(n816), .B(n1577), .Z(n1576) );
  GTECH_NOT U1606 ( .A(bus_hrdata[64]), .Z(n1577) );
  GTECH_NOR2 U1607 ( .A(n862), .B(n1578), .Z(n1575) );
  GTECH_NOR2 U1608 ( .A(n1579), .B(n1580), .Z(n1578) );
  GTECH_NOR2 U1609 ( .A(n817), .B(n1581), .Z(n1580) );
  GTECH_NOT U1610 ( .A(bus_hrdata[32]), .Z(n1581) );
  GTECH_NOR2 U1611 ( .A(n867), .B(n1582), .Z(n1579) );
  GTECH_NOR2 U1612 ( .A(n1583), .B(n1584), .Z(n1582) );
  GTECH_NOR2 U1613 ( .A(n818), .B(n1585), .Z(n1584) );
  GTECH_NOT U1614 ( .A(bus_hrdata[0]), .Z(n1585) );
  GTECH_NOR2 U1615 ( .A(n872), .B(n1586), .Z(n1583) );
  GTECH_NOT U1616 ( .A(hrdata_none[0]), .Z(n1586) );
  GTECH_NOT U1617 ( .A(n818), .Z(n872) );
  GTECH_NOT U1618 ( .A(n817), .Z(n867) );
  GTECH_NOT U1619 ( .A(n816), .Z(n862) );
  GTECH_NOT U1620 ( .A(n815), .Z(n857) );
  GTECH_NOT U1621 ( .A(n814), .Z(n852) );
endmodule


module DW_ahb_dcdr_32_00080000_00080fff_40000000_4000ffff ( haddr, remap_n, 
        hsel );
  input [31:0] haddr;
  output [5:0] hsel;
  input remap_n;
  wire   n110, n111, n112, n113, n114, n115, n116, n117, n118, n119, n120,
         n121, n122, n123, n124, n125, n126, n127, n128, n129, n130, n131,
         n132, n133, n134, n135, n136, n137, n138, n139, n140, n141, n142,
         n143, n144, n145, n146, n147, n148, n149, n150, n151, n152, n153,
         n154, n155, n156, n157, n158, n159, n160, n161, n162, n163, n164,
         n165, n166, n167, n168, n169, n170, n171, n172, n173, n174, n175,
         n176, n177, n178, n179, n180, n181, n182, n183, n184, n185, n186,
         n187;
  assign hsel[0] = 1'b0;

  GTECH_NOR2 U92 ( .A(n110), .B(n111), .Z(hsel[5]) );
  GTECH_NOT U93 ( .A(n112), .Z(n111) );
  GTECH_NOR2 U94 ( .A(hsel[2]), .B(hsel[1]), .Z(n112) );
  GTECH_NOT U95 ( .A(n113), .Z(n110) );
  GTECH_NOR2 U96 ( .A(hsel[4]), .B(hsel[3]), .Z(n113) );
  GTECH_NOR2 U97 ( .A(n114), .B(n115), .Z(hsel[4]) );
  GTECH_NOT U98 ( .A(n116), .Z(n115) );
  GTECH_NOR2 U99 ( .A(n117), .B(n118), .Z(n116) );
  GTECH_NOT U100 ( .A(n119), .Z(n118) );
  GTECH_NOR2 U101 ( .A(n120), .B(n121), .Z(n119) );
  GTECH_NOT U102 ( .A(n122), .Z(n117) );
  GTECH_NOR2 U103 ( .A(n123), .B(n124), .Z(n122) );
  GTECH_NOT U104 ( .A(n125), .Z(n114) );
  GTECH_NOR2 U105 ( .A(n126), .B(n127), .Z(n125) );
  GTECH_NOT U106 ( .A(n128), .Z(n127) );
  GTECH_NOR2 U107 ( .A(haddr[17]), .B(haddr[16]), .Z(n128) );
  GTECH_NOT U108 ( .A(n129), .Z(n126) );
  GTECH_NOR2 U109 ( .A(haddr[30]), .B(haddr[18]), .Z(n129) );
  GTECH_NOR2 U110 ( .A(n130), .B(n131), .Z(hsel[3]) );
  GTECH_NOT U111 ( .A(n132), .Z(n131) );
  GTECH_NOR2 U112 ( .A(n133), .B(n134), .Z(n132) );
  GTECH_NOT U113 ( .A(n123), .Z(n134) );
  GTECH_NOR2 U114 ( .A(n135), .B(n136), .Z(n123) );
  GTECH_NOT U115 ( .A(n137), .Z(n136) );
  GTECH_NOR2 U116 ( .A(haddr[30]), .B(n138), .Z(n137) );
  GTECH_NOR2 U117 ( .A(n139), .B(n133), .Z(n138) );
  GTECH_NOR2 U118 ( .A(n140), .B(n141), .Z(n139) );
  GTECH_NOR2 U119 ( .A(n142), .B(n143), .Z(n140) );
  GTECH_NOT U120 ( .A(haddr[12]), .Z(n142) );
  GTECH_NOT U121 ( .A(n144), .Z(n130) );
  GTECH_NOR2 U122 ( .A(n145), .B(n143), .Z(n144) );
  GTECH_NOT U123 ( .A(haddr[13]), .Z(n143) );
  GTECH_NOR2 U124 ( .A(n146), .B(n147), .Z(hsel[2]) );
  GTECH_NOT U125 ( .A(n148), .Z(n147) );
  GTECH_NOR2 U126 ( .A(n121), .B(n149), .Z(n148) );
  GTECH_NOT U127 ( .A(haddr[30]), .Z(n149) );
  GTECH_NOT U128 ( .A(n150), .Z(n121) );
  GTECH_NOR2 U129 ( .A(n145), .B(n151), .Z(n150) );
  GTECH_NOT U130 ( .A(n152), .Z(n151) );
  GTECH_NOR2 U131 ( .A(n135), .B(n153), .Z(n152) );
  GTECH_NOT U132 ( .A(n154), .Z(n146) );
  GTECH_NOR2 U133 ( .A(haddr[19]), .B(n155), .Z(n154) );
  GTECH_NOR2 U134 ( .A(n156), .B(n157), .Z(hsel[1]) );
  GTECH_NOT U135 ( .A(n158), .Z(n157) );
  GTECH_NOR2 U136 ( .A(n133), .B(n159), .Z(n158) );
  GTECH_NOT U137 ( .A(n160), .Z(n159) );
  GTECH_NOR2 U138 ( .A(n145), .B(n141), .Z(n160) );
  GTECH_NOT U139 ( .A(n161), .Z(n141) );
  GTECH_NOR2 U140 ( .A(n155), .B(n162), .Z(n161) );
  GTECH_NOT U141 ( .A(n163), .Z(n162) );
  GTECH_NOR2 U142 ( .A(n153), .B(n120), .Z(n163) );
  GTECH_NOT U143 ( .A(n164), .Z(n120) );
  GTECH_NOR2 U144 ( .A(haddr[15]), .B(haddr[14]), .Z(n164) );
  GTECH_NOT U145 ( .A(n165), .Z(n153) );
  GTECH_NOR2 U146 ( .A(haddr[22]), .B(n166), .Z(n165) );
  GTECH_NOT U147 ( .A(n167), .Z(n166) );
  GTECH_NOR2 U148 ( .A(haddr[24]), .B(haddr[23]), .Z(n167) );
  GTECH_NOT U149 ( .A(n168), .Z(n155) );
  GTECH_NOR2 U150 ( .A(n169), .B(n170), .Z(n168) );
  GTECH_NOT U151 ( .A(n171), .Z(n170) );
  GTECH_NOR2 U152 ( .A(haddr[16]), .B(n124), .Z(n171) );
  GTECH_NOT U153 ( .A(n172), .Z(n124) );
  GTECH_NOR2 U154 ( .A(haddr[21]), .B(haddr[20]), .Z(n172) );
  GTECH_NOT U155 ( .A(n173), .Z(n169) );
  GTECH_NOR2 U156 ( .A(haddr[18]), .B(haddr[17]), .Z(n173) );
  GTECH_NOT U157 ( .A(remap_n), .Z(n145) );
  GTECH_NOT U158 ( .A(haddr[19]), .Z(n133) );
  GTECH_NOT U159 ( .A(n174), .Z(n156) );
  GTECH_NOR2 U160 ( .A(n175), .B(n176), .Z(n174) );
  GTECH_NOT U161 ( .A(n177), .Z(n176) );
  GTECH_NOR2 U162 ( .A(haddr[12]), .B(n135), .Z(n177) );
  GTECH_NOT U163 ( .A(n178), .Z(n135) );
  GTECH_NOR2 U164 ( .A(n179), .B(n180), .Z(n178) );
  GTECH_NOT U165 ( .A(n181), .Z(n180) );
  GTECH_NOR2 U166 ( .A(haddr[25]), .B(n182), .Z(n181) );
  GTECH_NOT U167 ( .A(n183), .Z(n182) );
  GTECH_NOR2 U168 ( .A(haddr[27]), .B(haddr[26]), .Z(n183) );
  GTECH_NOT U169 ( .A(n184), .Z(n179) );
  GTECH_NOR2 U170 ( .A(haddr[28]), .B(n185), .Z(n184) );
  GTECH_NOT U171 ( .A(n186), .Z(n185) );
  GTECH_NOR2 U172 ( .A(haddr[31]), .B(haddr[29]), .Z(n186) );
  GTECH_NOT U173 ( .A(n187), .Z(n175) );
  GTECH_NOR2 U174 ( .A(haddr[30]), .B(haddr[13]), .Z(n187) );
endmodule


module DW_ahb_arbif_32_32_0 ( hclk, hresetn, hsel, hready, hmaster, set_ebt, 
        haddr, htrans, hsize, hwdata, hwrite, ahb_big_endian, hready_resp_s0, 
        hresp_s0, hrdata_s0, clr_arbint, ebtcount, ebten, def_mst, 
        bus_priority, maskmaster, wten, bus_ahb_icl, ahb_itcl );
  input [3:0] hmaster;
  input [31:0] haddr;
  input [1:0] htrans;
  input [2:0] hsize;
  input [255:0] hwdata;
  output [1:0] hresp_s0;
  output [31:0] hrdata_s0;
  output [9:0] ebtcount;
  output [3:0] def_mst;
  output [11:0] bus_priority;
  output [2:0] maskmaster;
  output [479:0] bus_ahb_icl;
  output [31:0] ahb_itcl;
  input hclk, hresetn, hsel, hready, set_ebt, hwrite, ahb_big_endian;
  output hready_resp_s0, clr_arbint, ebten, wten;
  wire   n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80, n81, n82,
         n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93, n94, n95, n96,
         n97;
  assign hready_resp_s0 = 1'b1;
  assign def_mst[0] = 1'b1;
  assign bus_priority[3] = 1'b1;
  assign bus_priority[2] = 1'b1;
  assign bus_priority[1] = 1'b1;
  assign bus_priority[0] = 1'b1;
  assign bus_ahb_icl[35] = 1'b1;
  assign bus_ahb_icl[34] = 1'b1;
  assign bus_ahb_icl[33] = 1'b1;
  assign bus_ahb_icl[32] = 1'b1;
  assign bus_ahb_icl[3] = 1'b1;
  assign bus_ahb_icl[2] = 1'b1;
  assign bus_ahb_icl[1] = 1'b1;
  assign bus_ahb_icl[0] = 1'b1;
  assign ahb_itcl[15] = 1'b1;
  assign ahb_itcl[14] = 1'b1;
  assign ahb_itcl[13] = 1'b1;
  assign ahb_itcl[12] = 1'b1;
  assign ahb_itcl[11] = 1'b1;
  assign ahb_itcl[10] = 1'b1;
  assign ahb_itcl[9] = 1'b1;
  assign ahb_itcl[8] = 1'b1;
  assign ahb_itcl[7] = 1'b1;
  assign ahb_itcl[6] = 1'b1;
  assign ahb_itcl[5] = 1'b1;
  assign ahb_itcl[4] = 1'b1;
  assign ahb_itcl[3] = 1'b1;
  assign ahb_itcl[2] = 1'b1;
  assign ahb_itcl[1] = 1'b1;
  assign ahb_itcl[0] = 1'b1;
  assign hresp_s0[1] = 1'b0;
  assign hresp_s0[0] = 1'b0;
  assign hrdata_s0[31] = 1'b0;
  assign hrdata_s0[30] = 1'b0;
  assign hrdata_s0[29] = 1'b0;
  assign hrdata_s0[28] = 1'b0;
  assign hrdata_s0[27] = 1'b0;
  assign hrdata_s0[26] = 1'b0;
  assign hrdata_s0[25] = 1'b0;
  assign hrdata_s0[24] = 1'b0;
  assign hrdata_s0[23] = 1'b0;
  assign hrdata_s0[22] = 1'b0;
  assign hrdata_s0[21] = 1'b0;
  assign hrdata_s0[20] = 1'b0;
  assign hrdata_s0[19] = 1'b0;
  assign hrdata_s0[18] = 1'b0;
  assign hrdata_s0[17] = 1'b0;
  assign hrdata_s0[16] = 1'b0;
  assign hrdata_s0[15] = 1'b0;
  assign hrdata_s0[14] = 1'b0;
  assign hrdata_s0[13] = 1'b0;
  assign hrdata_s0[12] = 1'b0;
  assign hrdata_s0[11] = 1'b0;
  assign hrdata_s0[10] = 1'b0;
  assign hrdata_s0[9] = 1'b0;
  assign hrdata_s0[8] = 1'b0;
  assign hrdata_s0[7] = 1'b0;
  assign hrdata_s0[6] = 1'b0;
  assign hrdata_s0[5] = 1'b0;
  assign hrdata_s0[4] = 1'b0;
  assign hrdata_s0[3] = 1'b0;
  assign hrdata_s0[2] = 1'b0;
  assign hrdata_s0[1] = 1'b0;
  assign hrdata_s0[0] = 1'b0;
  assign ebtcount[9] = 1'b0;
  assign ebtcount[8] = 1'b0;
  assign ebtcount[7] = 1'b0;
  assign ebtcount[6] = 1'b0;
  assign ebtcount[5] = 1'b0;
  assign ebtcount[4] = 1'b0;
  assign ebtcount[3] = 1'b0;
  assign ebtcount[2] = 1'b0;
  assign ebtcount[1] = 1'b0;
  assign ebtcount[0] = 1'b0;
  assign ebten = 1'b0;
  assign def_mst[3] = 1'b0;
  assign def_mst[2] = 1'b0;
  assign def_mst[1] = 1'b0;
  assign maskmaster[2] = 1'b0;
  assign maskmaster[1] = 1'b0;
  assign maskmaster[0] = 1'b0;
  assign wten = 1'b0;
  assign bus_ahb_icl[479] = 1'b0;
  assign bus_ahb_icl[478] = 1'b0;
  assign bus_ahb_icl[477] = 1'b0;
  assign bus_ahb_icl[476] = 1'b0;
  assign bus_ahb_icl[475] = 1'b0;
  assign bus_ahb_icl[474] = 1'b0;
  assign bus_ahb_icl[473] = 1'b0;
  assign bus_ahb_icl[472] = 1'b0;
  assign bus_ahb_icl[471] = 1'b0;
  assign bus_ahb_icl[470] = 1'b0;
  assign bus_ahb_icl[469] = 1'b0;
  assign bus_ahb_icl[468] = 1'b0;
  assign bus_ahb_icl[467] = 1'b0;
  assign bus_ahb_icl[466] = 1'b0;
  assign bus_ahb_icl[465] = 1'b0;
  assign bus_ahb_icl[464] = 1'b0;
  assign bus_ahb_icl[463] = 1'b0;
  assign bus_ahb_icl[462] = 1'b0;
  assign bus_ahb_icl[461] = 1'b0;
  assign bus_ahb_icl[460] = 1'b0;
  assign bus_ahb_icl[459] = 1'b0;
  assign bus_ahb_icl[458] = 1'b0;
  assign bus_ahb_icl[457] = 1'b0;
  assign bus_ahb_icl[456] = 1'b0;
  assign bus_ahb_icl[455] = 1'b0;
  assign bus_ahb_icl[454] = 1'b0;
  assign bus_ahb_icl[453] = 1'b0;
  assign bus_ahb_icl[452] = 1'b0;
  assign bus_ahb_icl[451] = 1'b0;
  assign bus_ahb_icl[450] = 1'b0;
  assign bus_ahb_icl[449] = 1'b0;
  assign bus_ahb_icl[448] = 1'b0;
  assign bus_ahb_icl[447] = 1'b0;
  assign bus_ahb_icl[446] = 1'b0;
  assign bus_ahb_icl[445] = 1'b0;
  assign bus_ahb_icl[444] = 1'b0;
  assign bus_ahb_icl[443] = 1'b0;
  assign bus_ahb_icl[442] = 1'b0;
  assign bus_ahb_icl[441] = 1'b0;
  assign bus_ahb_icl[440] = 1'b0;
  assign bus_ahb_icl[439] = 1'b0;
  assign bus_ahb_icl[438] = 1'b0;
  assign bus_ahb_icl[437] = 1'b0;
  assign bus_ahb_icl[436] = 1'b0;
  assign bus_ahb_icl[435] = 1'b0;
  assign bus_ahb_icl[434] = 1'b0;
  assign bus_ahb_icl[433] = 1'b0;
  assign bus_ahb_icl[432] = 1'b0;
  assign bus_ahb_icl[431] = 1'b0;
  assign bus_ahb_icl[430] = 1'b0;
  assign bus_ahb_icl[429] = 1'b0;
  assign bus_ahb_icl[428] = 1'b0;
  assign bus_ahb_icl[427] = 1'b0;
  assign bus_ahb_icl[426] = 1'b0;
  assign bus_ahb_icl[425] = 1'b0;
  assign bus_ahb_icl[424] = 1'b0;
  assign bus_ahb_icl[423] = 1'b0;
  assign bus_ahb_icl[422] = 1'b0;
  assign bus_ahb_icl[421] = 1'b0;
  assign bus_ahb_icl[420] = 1'b0;
  assign bus_ahb_icl[419] = 1'b0;
  assign bus_ahb_icl[418] = 1'b0;
  assign bus_ahb_icl[417] = 1'b0;
  assign bus_ahb_icl[416] = 1'b0;
  assign bus_ahb_icl[415] = 1'b0;
  assign bus_ahb_icl[414] = 1'b0;
  assign bus_ahb_icl[413] = 1'b0;
  assign bus_ahb_icl[412] = 1'b0;
  assign bus_ahb_icl[411] = 1'b0;
  assign bus_ahb_icl[410] = 1'b0;
  assign bus_ahb_icl[409] = 1'b0;
  assign bus_ahb_icl[408] = 1'b0;
  assign bus_ahb_icl[407] = 1'b0;
  assign bus_ahb_icl[406] = 1'b0;
  assign bus_ahb_icl[405] = 1'b0;
  assign bus_ahb_icl[404] = 1'b0;
  assign bus_ahb_icl[403] = 1'b0;
  assign bus_ahb_icl[402] = 1'b0;
  assign bus_ahb_icl[401] = 1'b0;
  assign bus_ahb_icl[400] = 1'b0;
  assign bus_ahb_icl[399] = 1'b0;
  assign bus_ahb_icl[398] = 1'b0;
  assign bus_ahb_icl[397] = 1'b0;
  assign bus_ahb_icl[396] = 1'b0;
  assign bus_ahb_icl[395] = 1'b0;
  assign bus_ahb_icl[394] = 1'b0;
  assign bus_ahb_icl[393] = 1'b0;
  assign bus_ahb_icl[392] = 1'b0;
  assign bus_ahb_icl[391] = 1'b0;
  assign bus_ahb_icl[390] = 1'b0;
  assign bus_ahb_icl[389] = 1'b0;
  assign bus_ahb_icl[388] = 1'b0;
  assign bus_ahb_icl[387] = 1'b0;
  assign bus_ahb_icl[386] = 1'b0;
  assign bus_ahb_icl[385] = 1'b0;
  assign bus_ahb_icl[384] = 1'b0;
  assign bus_ahb_icl[383] = 1'b0;
  assign bus_ahb_icl[382] = 1'b0;
  assign bus_ahb_icl[381] = 1'b0;
  assign bus_ahb_icl[380] = 1'b0;
  assign bus_ahb_icl[379] = 1'b0;
  assign bus_ahb_icl[378] = 1'b0;
  assign bus_ahb_icl[377] = 1'b0;
  assign bus_ahb_icl[376] = 1'b0;
  assign bus_ahb_icl[375] = 1'b0;
  assign bus_ahb_icl[374] = 1'b0;
  assign bus_ahb_icl[373] = 1'b0;
  assign bus_ahb_icl[372] = 1'b0;
  assign bus_ahb_icl[371] = 1'b0;
  assign bus_ahb_icl[370] = 1'b0;
  assign bus_ahb_icl[369] = 1'b0;
  assign bus_ahb_icl[368] = 1'b0;
  assign bus_ahb_icl[367] = 1'b0;
  assign bus_ahb_icl[366] = 1'b0;
  assign bus_ahb_icl[365] = 1'b0;
  assign bus_ahb_icl[364] = 1'b0;
  assign bus_ahb_icl[363] = 1'b0;
  assign bus_ahb_icl[362] = 1'b0;
  assign bus_ahb_icl[361] = 1'b0;
  assign bus_ahb_icl[360] = 1'b0;
  assign bus_ahb_icl[359] = 1'b0;
  assign bus_ahb_icl[358] = 1'b0;
  assign bus_ahb_icl[357] = 1'b0;
  assign bus_ahb_icl[356] = 1'b0;
  assign bus_ahb_icl[355] = 1'b0;
  assign bus_ahb_icl[354] = 1'b0;
  assign bus_ahb_icl[353] = 1'b0;
  assign bus_ahb_icl[352] = 1'b0;
  assign bus_ahb_icl[351] = 1'b0;
  assign bus_ahb_icl[350] = 1'b0;
  assign bus_ahb_icl[349] = 1'b0;
  assign bus_ahb_icl[348] = 1'b0;
  assign bus_ahb_icl[347] = 1'b0;
  assign bus_ahb_icl[346] = 1'b0;
  assign bus_ahb_icl[345] = 1'b0;
  assign bus_ahb_icl[344] = 1'b0;
  assign bus_ahb_icl[343] = 1'b0;
  assign bus_ahb_icl[342] = 1'b0;
  assign bus_ahb_icl[341] = 1'b0;
  assign bus_ahb_icl[340] = 1'b0;
  assign bus_ahb_icl[339] = 1'b0;
  assign bus_ahb_icl[338] = 1'b0;
  assign bus_ahb_icl[337] = 1'b0;
  assign bus_ahb_icl[336] = 1'b0;
  assign bus_ahb_icl[335] = 1'b0;
  assign bus_ahb_icl[334] = 1'b0;
  assign bus_ahb_icl[333] = 1'b0;
  assign bus_ahb_icl[332] = 1'b0;
  assign bus_ahb_icl[331] = 1'b0;
  assign bus_ahb_icl[330] = 1'b0;
  assign bus_ahb_icl[329] = 1'b0;
  assign bus_ahb_icl[328] = 1'b0;
  assign bus_ahb_icl[327] = 1'b0;
  assign bus_ahb_icl[326] = 1'b0;
  assign bus_ahb_icl[325] = 1'b0;
  assign bus_ahb_icl[324] = 1'b0;
  assign bus_ahb_icl[323] = 1'b0;
  assign bus_ahb_icl[322] = 1'b0;
  assign bus_ahb_icl[321] = 1'b0;
  assign bus_ahb_icl[320] = 1'b0;
  assign bus_ahb_icl[319] = 1'b0;
  assign bus_ahb_icl[318] = 1'b0;
  assign bus_ahb_icl[317] = 1'b0;
  assign bus_ahb_icl[316] = 1'b0;
  assign bus_ahb_icl[315] = 1'b0;
  assign bus_ahb_icl[314] = 1'b0;
  assign bus_ahb_icl[313] = 1'b0;
  assign bus_ahb_icl[312] = 1'b0;
  assign bus_ahb_icl[311] = 1'b0;
  assign bus_ahb_icl[310] = 1'b0;
  assign bus_ahb_icl[309] = 1'b0;
  assign bus_ahb_icl[308] = 1'b0;
  assign bus_ahb_icl[307] = 1'b0;
  assign bus_ahb_icl[306] = 1'b0;
  assign bus_ahb_icl[305] = 1'b0;
  assign bus_ahb_icl[304] = 1'b0;
  assign bus_ahb_icl[303] = 1'b0;
  assign bus_ahb_icl[302] = 1'b0;
  assign bus_ahb_icl[301] = 1'b0;
  assign bus_ahb_icl[300] = 1'b0;
  assign bus_ahb_icl[299] = 1'b0;
  assign bus_ahb_icl[298] = 1'b0;
  assign bus_ahb_icl[297] = 1'b0;
  assign bus_ahb_icl[296] = 1'b0;
  assign bus_ahb_icl[295] = 1'b0;
  assign bus_ahb_icl[294] = 1'b0;
  assign bus_ahb_icl[293] = 1'b0;
  assign bus_ahb_icl[292] = 1'b0;
  assign bus_ahb_icl[291] = 1'b0;
  assign bus_ahb_icl[290] = 1'b0;
  assign bus_ahb_icl[289] = 1'b0;
  assign bus_ahb_icl[288] = 1'b0;
  assign bus_ahb_icl[287] = 1'b0;
  assign bus_ahb_icl[286] = 1'b0;
  assign bus_ahb_icl[285] = 1'b0;
  assign bus_ahb_icl[284] = 1'b0;
  assign bus_ahb_icl[283] = 1'b0;
  assign bus_ahb_icl[282] = 1'b0;
  assign bus_ahb_icl[281] = 1'b0;
  assign bus_ahb_icl[280] = 1'b0;
  assign bus_ahb_icl[279] = 1'b0;
  assign bus_ahb_icl[278] = 1'b0;
  assign bus_ahb_icl[277] = 1'b0;
  assign bus_ahb_icl[276] = 1'b0;
  assign bus_ahb_icl[275] = 1'b0;
  assign bus_ahb_icl[274] = 1'b0;
  assign bus_ahb_icl[273] = 1'b0;
  assign bus_ahb_icl[272] = 1'b0;
  assign bus_ahb_icl[271] = 1'b0;
  assign bus_ahb_icl[270] = 1'b0;
  assign bus_ahb_icl[269] = 1'b0;
  assign bus_ahb_icl[268] = 1'b0;
  assign bus_ahb_icl[267] = 1'b0;
  assign bus_ahb_icl[266] = 1'b0;
  assign bus_ahb_icl[265] = 1'b0;
  assign bus_ahb_icl[264] = 1'b0;
  assign bus_ahb_icl[263] = 1'b0;
  assign bus_ahb_icl[262] = 1'b0;
  assign bus_ahb_icl[261] = 1'b0;
  assign bus_ahb_icl[260] = 1'b0;
  assign bus_ahb_icl[259] = 1'b0;
  assign bus_ahb_icl[258] = 1'b0;
  assign bus_ahb_icl[257] = 1'b0;
  assign bus_ahb_icl[256] = 1'b0;
  assign bus_ahb_icl[255] = 1'b0;
  assign bus_ahb_icl[254] = 1'b0;
  assign bus_ahb_icl[253] = 1'b0;
  assign bus_ahb_icl[252] = 1'b0;
  assign bus_ahb_icl[251] = 1'b0;
  assign bus_ahb_icl[250] = 1'b0;
  assign bus_ahb_icl[249] = 1'b0;
  assign bus_ahb_icl[248] = 1'b0;
  assign bus_ahb_icl[247] = 1'b0;
  assign bus_ahb_icl[246] = 1'b0;
  assign bus_ahb_icl[245] = 1'b0;
  assign bus_ahb_icl[244] = 1'b0;
  assign bus_ahb_icl[243] = 1'b0;
  assign bus_ahb_icl[242] = 1'b0;
  assign bus_ahb_icl[241] = 1'b0;
  assign bus_ahb_icl[240] = 1'b0;
  assign bus_ahb_icl[239] = 1'b0;
  assign bus_ahb_icl[238] = 1'b0;
  assign bus_ahb_icl[237] = 1'b0;
  assign bus_ahb_icl[236] = 1'b0;
  assign bus_ahb_icl[235] = 1'b0;
  assign bus_ahb_icl[234] = 1'b0;
  assign bus_ahb_icl[233] = 1'b0;
  assign bus_ahb_icl[232] = 1'b0;
  assign bus_ahb_icl[231] = 1'b0;
  assign bus_ahb_icl[230] = 1'b0;
  assign bus_ahb_icl[229] = 1'b0;
  assign bus_ahb_icl[228] = 1'b0;
  assign bus_ahb_icl[227] = 1'b0;
  assign bus_ahb_icl[226] = 1'b0;
  assign bus_ahb_icl[225] = 1'b0;
  assign bus_ahb_icl[224] = 1'b0;
  assign bus_ahb_icl[223] = 1'b0;
  assign bus_ahb_icl[222] = 1'b0;
  assign bus_ahb_icl[221] = 1'b0;
  assign bus_ahb_icl[220] = 1'b0;
  assign bus_ahb_icl[219] = 1'b0;
  assign bus_ahb_icl[218] = 1'b0;
  assign bus_ahb_icl[217] = 1'b0;
  assign bus_ahb_icl[216] = 1'b0;
  assign bus_ahb_icl[215] = 1'b0;
  assign bus_ahb_icl[214] = 1'b0;
  assign bus_ahb_icl[213] = 1'b0;
  assign bus_ahb_icl[212] = 1'b0;
  assign bus_ahb_icl[211] = 1'b0;
  assign bus_ahb_icl[210] = 1'b0;
  assign bus_ahb_icl[209] = 1'b0;
  assign bus_ahb_icl[208] = 1'b0;
  assign bus_ahb_icl[207] = 1'b0;
  assign bus_ahb_icl[206] = 1'b0;
  assign bus_ahb_icl[205] = 1'b0;
  assign bus_ahb_icl[204] = 1'b0;
  assign bus_ahb_icl[203] = 1'b0;
  assign bus_ahb_icl[202] = 1'b0;
  assign bus_ahb_icl[201] = 1'b0;
  assign bus_ahb_icl[200] = 1'b0;
  assign bus_ahb_icl[199] = 1'b0;
  assign bus_ahb_icl[198] = 1'b0;
  assign bus_ahb_icl[197] = 1'b0;
  assign bus_ahb_icl[196] = 1'b0;
  assign bus_ahb_icl[195] = 1'b0;
  assign bus_ahb_icl[194] = 1'b0;
  assign bus_ahb_icl[193] = 1'b0;
  assign bus_ahb_icl[192] = 1'b0;
  assign bus_ahb_icl[191] = 1'b0;
  assign bus_ahb_icl[190] = 1'b0;
  assign bus_ahb_icl[189] = 1'b0;
  assign bus_ahb_icl[188] = 1'b0;
  assign bus_ahb_icl[187] = 1'b0;
  assign bus_ahb_icl[186] = 1'b0;
  assign bus_ahb_icl[185] = 1'b0;
  assign bus_ahb_icl[184] = 1'b0;
  assign bus_ahb_icl[183] = 1'b0;
  assign bus_ahb_icl[182] = 1'b0;
  assign bus_ahb_icl[181] = 1'b0;
  assign bus_ahb_icl[180] = 1'b0;
  assign bus_ahb_icl[179] = 1'b0;
  assign bus_ahb_icl[178] = 1'b0;
  assign bus_ahb_icl[177] = 1'b0;
  assign bus_ahb_icl[176] = 1'b0;
  assign bus_ahb_icl[175] = 1'b0;
  assign bus_ahb_icl[174] = 1'b0;
  assign bus_ahb_icl[173] = 1'b0;
  assign bus_ahb_icl[172] = 1'b0;
  assign bus_ahb_icl[171] = 1'b0;
  assign bus_ahb_icl[170] = 1'b0;
  assign bus_ahb_icl[169] = 1'b0;
  assign bus_ahb_icl[168] = 1'b0;
  assign bus_ahb_icl[167] = 1'b0;
  assign bus_ahb_icl[166] = 1'b0;
  assign bus_ahb_icl[165] = 1'b0;
  assign bus_ahb_icl[164] = 1'b0;
  assign bus_ahb_icl[163] = 1'b0;
  assign bus_ahb_icl[162] = 1'b0;
  assign bus_ahb_icl[161] = 1'b0;
  assign bus_ahb_icl[160] = 1'b0;
  assign bus_ahb_icl[159] = 1'b0;
  assign bus_ahb_icl[158] = 1'b0;
  assign bus_ahb_icl[157] = 1'b0;
  assign bus_ahb_icl[156] = 1'b0;
  assign bus_ahb_icl[155] = 1'b0;
  assign bus_ahb_icl[154] = 1'b0;
  assign bus_ahb_icl[153] = 1'b0;
  assign bus_ahb_icl[152] = 1'b0;
  assign bus_ahb_icl[151] = 1'b0;
  assign bus_ahb_icl[150] = 1'b0;
  assign bus_ahb_icl[149] = 1'b0;
  assign bus_ahb_icl[148] = 1'b0;
  assign bus_ahb_icl[147] = 1'b0;
  assign bus_ahb_icl[146] = 1'b0;
  assign bus_ahb_icl[145] = 1'b0;
  assign bus_ahb_icl[144] = 1'b0;
  assign bus_ahb_icl[143] = 1'b0;
  assign bus_ahb_icl[142] = 1'b0;
  assign bus_ahb_icl[141] = 1'b0;
  assign bus_ahb_icl[140] = 1'b0;
  assign bus_ahb_icl[139] = 1'b0;
  assign bus_ahb_icl[138] = 1'b0;
  assign bus_ahb_icl[137] = 1'b0;
  assign bus_ahb_icl[136] = 1'b0;
  assign bus_ahb_icl[135] = 1'b0;
  assign bus_ahb_icl[134] = 1'b0;
  assign bus_ahb_icl[133] = 1'b0;
  assign bus_ahb_icl[132] = 1'b0;
  assign bus_ahb_icl[131] = 1'b0;
  assign bus_ahb_icl[130] = 1'b0;
  assign bus_ahb_icl[129] = 1'b0;
  assign bus_ahb_icl[128] = 1'b0;
  assign bus_ahb_icl[127] = 1'b0;
  assign bus_ahb_icl[126] = 1'b0;
  assign bus_ahb_icl[125] = 1'b0;
  assign bus_ahb_icl[124] = 1'b0;
  assign bus_ahb_icl[123] = 1'b0;
  assign bus_ahb_icl[122] = 1'b0;
  assign bus_ahb_icl[121] = 1'b0;
  assign bus_ahb_icl[120] = 1'b0;
  assign bus_ahb_icl[119] = 1'b0;
  assign bus_ahb_icl[118] = 1'b0;
  assign bus_ahb_icl[117] = 1'b0;
  assign bus_ahb_icl[116] = 1'b0;
  assign bus_ahb_icl[115] = 1'b0;
  assign bus_ahb_icl[114] = 1'b0;
  assign bus_ahb_icl[113] = 1'b0;
  assign bus_ahb_icl[112] = 1'b0;
  assign bus_ahb_icl[111] = 1'b0;
  assign bus_ahb_icl[110] = 1'b0;
  assign bus_ahb_icl[109] = 1'b0;
  assign bus_ahb_icl[108] = 1'b0;
  assign bus_ahb_icl[107] = 1'b0;
  assign bus_ahb_icl[106] = 1'b0;
  assign bus_ahb_icl[105] = 1'b0;
  assign bus_ahb_icl[104] = 1'b0;
  assign bus_ahb_icl[103] = 1'b0;
  assign bus_ahb_icl[102] = 1'b0;
  assign bus_ahb_icl[101] = 1'b0;
  assign bus_ahb_icl[100] = 1'b0;
  assign bus_ahb_icl[99] = 1'b0;
  assign bus_ahb_icl[98] = 1'b0;
  assign bus_ahb_icl[97] = 1'b0;
  assign bus_ahb_icl[96] = 1'b0;
  assign bus_ahb_icl[95] = 1'b0;
  assign bus_ahb_icl[94] = 1'b0;
  assign bus_ahb_icl[93] = 1'b0;
  assign bus_ahb_icl[92] = 1'b0;
  assign bus_ahb_icl[91] = 1'b0;
  assign bus_ahb_icl[90] = 1'b0;
  assign bus_ahb_icl[89] = 1'b0;
  assign bus_ahb_icl[88] = 1'b0;
  assign bus_ahb_icl[87] = 1'b0;
  assign bus_ahb_icl[86] = 1'b0;
  assign bus_ahb_icl[85] = 1'b0;
  assign bus_ahb_icl[84] = 1'b0;
  assign bus_ahb_icl[83] = 1'b0;
  assign bus_ahb_icl[82] = 1'b0;
  assign bus_ahb_icl[81] = 1'b0;
  assign bus_ahb_icl[80] = 1'b0;
  assign bus_ahb_icl[79] = 1'b0;
  assign bus_ahb_icl[78] = 1'b0;
  assign bus_ahb_icl[77] = 1'b0;
  assign bus_ahb_icl[76] = 1'b0;
  assign bus_ahb_icl[75] = 1'b0;
  assign bus_ahb_icl[74] = 1'b0;
  assign bus_ahb_icl[73] = 1'b0;
  assign bus_ahb_icl[72] = 1'b0;
  assign bus_ahb_icl[71] = 1'b0;
  assign bus_ahb_icl[70] = 1'b0;
  assign bus_ahb_icl[69] = 1'b0;
  assign bus_ahb_icl[68] = 1'b0;
  assign bus_ahb_icl[67] = 1'b0;
  assign bus_ahb_icl[66] = 1'b0;
  assign bus_ahb_icl[65] = 1'b0;
  assign bus_ahb_icl[64] = 1'b0;
  assign bus_ahb_icl[63] = 1'b0;
  assign bus_ahb_icl[62] = 1'b0;
  assign bus_ahb_icl[61] = 1'b0;
  assign bus_ahb_icl[60] = 1'b0;
  assign bus_ahb_icl[59] = 1'b0;
  assign bus_ahb_icl[58] = 1'b0;
  assign bus_ahb_icl[57] = 1'b0;
  assign bus_ahb_icl[56] = 1'b0;
  assign bus_ahb_icl[55] = 1'b0;
  assign bus_ahb_icl[54] = 1'b0;
  assign bus_ahb_icl[53] = 1'b0;
  assign bus_ahb_icl[52] = 1'b0;
  assign bus_ahb_icl[51] = 1'b0;
  assign bus_ahb_icl[50] = 1'b0;
  assign bus_ahb_icl[49] = 1'b0;
  assign bus_ahb_icl[48] = 1'b0;
  assign bus_ahb_icl[47] = 1'b0;
  assign bus_ahb_icl[46] = 1'b0;
  assign bus_ahb_icl[45] = 1'b0;
  assign bus_ahb_icl[44] = 1'b0;
  assign bus_ahb_icl[43] = 1'b0;
  assign bus_ahb_icl[42] = 1'b0;
  assign bus_ahb_icl[41] = 1'b0;
  assign bus_ahb_icl[40] = 1'b0;
  assign bus_ahb_icl[39] = 1'b0;
  assign bus_ahb_icl[38] = 1'b0;
  assign bus_ahb_icl[37] = 1'b0;
  assign bus_ahb_icl[36] = 1'b0;
  assign bus_ahb_icl[31] = 1'b0;
  assign bus_ahb_icl[30] = 1'b0;
  assign bus_ahb_icl[29] = 1'b0;
  assign bus_ahb_icl[28] = 1'b0;
  assign bus_ahb_icl[27] = 1'b0;
  assign bus_ahb_icl[26] = 1'b0;
  assign bus_ahb_icl[25] = 1'b0;
  assign bus_ahb_icl[24] = 1'b0;
  assign bus_ahb_icl[23] = 1'b0;
  assign bus_ahb_icl[22] = 1'b0;
  assign bus_ahb_icl[21] = 1'b0;
  assign bus_ahb_icl[20] = 1'b0;
  assign bus_ahb_icl[19] = 1'b0;
  assign bus_ahb_icl[18] = 1'b0;
  assign bus_ahb_icl[17] = 1'b0;
  assign bus_ahb_icl[16] = 1'b0;
  assign bus_ahb_icl[15] = 1'b0;
  assign bus_ahb_icl[14] = 1'b0;
  assign bus_ahb_icl[13] = 1'b0;
  assign bus_ahb_icl[12] = 1'b0;
  assign bus_ahb_icl[11] = 1'b0;
  assign bus_ahb_icl[10] = 1'b0;
  assign bus_ahb_icl[9] = 1'b0;
  assign bus_ahb_icl[8] = 1'b0;
  assign bus_ahb_icl[7] = 1'b0;
  assign bus_ahb_icl[6] = 1'b0;
  assign bus_ahb_icl[5] = 1'b0;
  assign bus_ahb_icl[4] = 1'b0;
  assign ahb_itcl[31] = 1'b0;
  assign ahb_itcl[30] = 1'b0;
  assign ahb_itcl[29] = 1'b0;
  assign ahb_itcl[28] = 1'b0;
  assign ahb_itcl[27] = 1'b0;
  assign ahb_itcl[26] = 1'b0;
  assign ahb_itcl[25] = 1'b0;
  assign ahb_itcl[24] = 1'b0;
  assign ahb_itcl[23] = 1'b0;
  assign ahb_itcl[22] = 1'b0;
  assign ahb_itcl[21] = 1'b0;
  assign ahb_itcl[20] = 1'b0;
  assign ahb_itcl[19] = 1'b0;
  assign ahb_itcl[18] = 1'b0;
  assign ahb_itcl[17] = 1'b0;
  assign ahb_itcl[16] = 1'b0;
  assign bus_priority[11] = 1'b1;
  assign bus_priority[10] = 1'b1;
  assign bus_priority[8] = 1'b1;
  assign bus_priority[7] = 1'b1;
  assign bus_priority[6] = 1'b1;
  assign bus_priority[5] = 1'b1;
  assign bus_priority[9] = 1'b0;
  assign bus_priority[4] = 1'b0;

  GTECH_NOR2 U52 ( .A(n69), .B(n70), .Z(clr_arbint) );
  GTECH_NOT U53 ( .A(n71), .Z(n70) );
  GTECH_NOR2 U54 ( .A(n72), .B(n73), .Z(n71) );
  GTECH_NOT U55 ( .A(n74), .Z(n73) );
  GTECH_NOR2 U56 ( .A(n75), .B(n76), .Z(n74) );
  GTECH_NOT U57 ( .A(n77), .Z(n76) );
  GTECH_NOR2 U58 ( .A(n78), .B(n79), .Z(n77) );
  GTECH_NOT U59 ( .A(hsel), .Z(n79) );
  GTECH_NOT U60 ( .A(hready), .Z(n78) );
  GTECH_NOT U61 ( .A(htrans[1]), .Z(n75) );
  GTECH_NOT U62 ( .A(n80), .Z(n72) );
  GTECH_NOR2 U63 ( .A(n81), .B(n82), .Z(n80) );
  GTECH_NOT U64 ( .A(n83), .Z(n82) );
  GTECH_NOR2 U65 ( .A(n84), .B(n85), .Z(n83) );
  GTECH_NOT U66 ( .A(haddr[6]), .Z(n85) );
  GTECH_NOT U67 ( .A(haddr[2]), .Z(n84) );
  GTECH_NOT U68 ( .A(n86), .Z(n81) );
  GTECH_NOR2 U69 ( .A(haddr[1]), .B(haddr[0]), .Z(n86) );
  GTECH_NOT U70 ( .A(n87), .Z(n69) );
  GTECH_NOR2 U71 ( .A(n88), .B(n89), .Z(n87) );
  GTECH_NOT U72 ( .A(n90), .Z(n89) );
  GTECH_NOR2 U73 ( .A(haddr[3]), .B(n91), .Z(n90) );
  GTECH_NOT U74 ( .A(n92), .Z(n91) );
  GTECH_NOR2 U75 ( .A(haddr[5]), .B(haddr[4]), .Z(n92) );
  GTECH_NOT U76 ( .A(n93), .Z(n88) );
  GTECH_NOR2 U77 ( .A(n94), .B(n95), .Z(n93) );
  GTECH_NOT U78 ( .A(n96), .Z(n95) );
  GTECH_NOR2 U79 ( .A(haddr[8]), .B(haddr[7]), .Z(n96) );
  GTECH_NOT U80 ( .A(n97), .Z(n94) );
  GTECH_NOR2 U81 ( .A(hwrite), .B(haddr[9]), .Z(n97) );
endmodule


module DW_ahb_ebt ( hclk, hresetn, hready, ebtcount, ebten, clr_arbint, 
        new_tfr, ltip, grant_changed, ahbarbint, set_ebt );
  input [9:0] ebtcount;
  input hclk, hresetn, hready, ebten, clr_arbint, new_tfr, ltip, grant_changed;
  output ahbarbint, set_ebt;

  assign ahbarbint = 1'b0;
  assign set_ebt = 1'b0;

endmodule


module DW_ahb_mask ( hclk, hresetn, hresp, bus_hsplit, hmaster_data, 
        maskmaster, bus_priority, ltip, hready, csilt, est, hsplit, mask );
  input [1:0] hresp;
  input [63:0] bus_hsplit;
  input [3:0] hmaster_data;
  input [2:0] maskmaster;
  input [11:0] bus_priority;
  output [15:0] hsplit;
  output [2:0] mask;
  input hclk, hresetn, ltip, hready, csilt, est;
  wire   extend_ltip, n281, n284, n287, n307, n308, n309, n310, n311, n312,
         n313, n314, n315, n316, n317, n318, n319, n320, n321, n322, n323,
         n324, n325, n326, n327, n328, n329, n330, n331, n332, n333, n334,
         n335, n336, n337, n338, n339, n340, n341, n342, n343, n344, n345,
         n346, n347, n348, n349, n350, n351, n352, n353, n354, n355, n356,
         n357, n358, n359, n360, n361, n362, n363, n364, n365, n366, n367,
         n368, n369, n370, n371, n372, n373, n374, n375, n376, n377, n378,
         n379, n380, n381, n382, n383, n384, n385, n386, n387, n388, n389,
         n390, n391, n392, n393, n394, n395, n396, n397, n398, n399, n400,
         n401, n402, n403, n404, n405, n406, n407, n408, n409, n410, n411,
         n412, n413, n414, n415, n416, n417, n418, n419, n420, n421, n422,
         n423, n424, n425, n426, n427, n428, n429, n430, n431, n432, n433,
         n434, n435, n436, n437, n438, n439, n440, n441, n442, n443, n444,
         n445, n446, n447, n448, n449, n450, n451, n452, n453, n454, n455,
         n456, n457, n458, n459, n460, n461, n462, n463, n464, n465, n466,
         n467, n468, n469, n470, n471, n472, n473, n474, n475, n476, n477,
         n478, n479, n480, n481, n482, n483, n484, n485, n486, n487, n488,
         n489, n490, n491, n492, n493, n494, n495, n496, n497, n498, n499,
         n500, n501, n502, n503, n504, n505, n506, n507, n508, n509, n510,
         n511, n512, n513, n514, n515, n516, n517, n518, n519, n520, n521,
         n522, n523, n524, n525, n526, n527, n528, n529, n530, n531, n532,
         n533, n534, n535, n536, n537, n538, n539, n540, n541, n542, n543,
         n544, n545, n546, n547, n548, n549, n550, n551, n552, n553, n554,
         n555, n556, n557, n558, n559, n560, n561, n562, n563, n564, n565,
         n566, n567, n568, n569, n570, n571, n572, n573, n574, n575, n576,
         n577, n578, n579, n580, n581, n582, n583, n584, n585, n586, n587,
         n588, n589, n590, n591, n592, n593, n594, n595, n596, n597, n598,
         n602, n603, n604, n605, n622;
  wire   [2:1] r_rec_hsplit;
  wire   [2:1] r_mask_locked;

  GTECH_FD2 r_rec_hsplit_reg_2_ ( .D(n602), .CP(hclk), .CD(hresetn), .Q(
        r_rec_hsplit[2]), .QN(n281) );
  GTECH_FD2 r_rec_hsplit_reg_1_ ( .D(n603), .CP(hclk), .CD(hresetn), .Q(
        r_rec_hsplit[1]), .QN(n284) );
  GTECH_FD2 extend_ltip_reg ( .D(n622), .CP(hclk), .CD(hresetn), .Q(
        extend_ltip), .QN(n287) );
  GTECH_FD2 r_mask_locked_reg_2_ ( .D(n604), .CP(hclk), .CD(hresetn), .Q(
        r_mask_locked[2]) );
  GTECH_FD2 r_mask_locked_reg_1_ ( .D(n605), .CP(hclk), .CD(hresetn), .Q(
        r_mask_locked[1]) );
  GTECH_NOT U289 ( .A(n307), .Z(mask[0]) );
  GTECH_NOR2 U290 ( .A(n308), .B(n309), .Z(n307) );
  GTECH_NOT U291 ( .A(n310), .Z(n309) );
  GTECH_NOR2 U292 ( .A(n311), .B(n312), .Z(n310) );
  GTECH_NOR2 U293 ( .A(n313), .B(n314), .Z(n312) );
  GTECH_NOT U294 ( .A(n315), .Z(n314) );
  GTECH_NOR2 U295 ( .A(hready), .B(n316), .Z(n315) );
  GTECH_NOR2 U296 ( .A(n317), .B(n318), .Z(n316) );
  GTECH_NOR2 U297 ( .A(n319), .B(n320), .Z(n311) );
  GTECH_NOT U298 ( .A(n321), .Z(n320) );
  GTECH_NOR2 U299 ( .A(hready), .B(n322), .Z(n321) );
  GTECH_NOR2 U300 ( .A(n323), .B(n324), .Z(n322) );
  GTECH_NOR2 U301 ( .A(n325), .B(n326), .Z(n324) );
  GTECH_NOT U302 ( .A(bus_priority[3]), .Z(n326) );
  GTECH_NOR2 U303 ( .A(n327), .B(n328), .Z(n323) );
  GTECH_NOT U304 ( .A(n329), .Z(n328) );
  GTECH_NOR2 U305 ( .A(n330), .B(n331), .Z(n329) );
  GTECH_NOR2 U306 ( .A(bus_priority[3]), .B(n332), .Z(n331) );
  GTECH_NOR2 U307 ( .A(n333), .B(n334), .Z(n330) );
  GTECH_NOT U308 ( .A(n335), .Z(n334) );
  GTECH_NOR2 U309 ( .A(bus_priority[0]), .B(n336), .Z(n335) );
  GTECH_NOR2 U310 ( .A(n337), .B(n336), .Z(n327) );
  GTECH_NOT U311 ( .A(n338), .Z(n336) );
  GTECH_NOR2 U312 ( .A(n339), .B(n340), .Z(n338) );
  GTECH_NOR2 U313 ( .A(n341), .B(n342), .Z(n340) );
  GTECH_NOT U314 ( .A(bus_priority[2]), .Z(n342) );
  GTECH_NOR2 U315 ( .A(n343), .B(n344), .Z(n339) );
  GTECH_NOT U316 ( .A(n345), .Z(n344) );
  GTECH_NOR2 U317 ( .A(n346), .B(n347), .Z(n345) );
  GTECH_NOT U318 ( .A(bus_priority[1]), .Z(n343) );
  GTECH_NOR2 U319 ( .A(n347), .B(n348), .Z(n337) );
  GTECH_NOR2 U320 ( .A(bus_priority[1]), .B(n349), .Z(n348) );
  GTECH_NOR2 U321 ( .A(bus_priority[2]), .B(n350), .Z(n347) );
  GTECH_NOT U322 ( .A(n351), .Z(n308) );
  GTECH_NOR2 U323 ( .A(maskmaster[0]), .B(n352), .Z(n351) );
  GTECH_NOR2 U324 ( .A(n353), .B(n354), .Z(n352) );
  GTECH_NOT U325 ( .A(n355), .Z(n354) );
  GTECH_NOR2 U326 ( .A(n317), .B(n356), .Z(n355) );
  GTECH_NOT U327 ( .A(n357), .Z(n317) );
  GTECH_NOR2 U328 ( .A(hmaster_data[1]), .B(hmaster_data[0]), .Z(n357) );
  GTECH_NOT U329 ( .A(n358), .Z(mask[2]) );
  GTECH_NOR2 U330 ( .A(n359), .B(n360), .Z(n358) );
  GTECH_NOT U331 ( .A(n361), .Z(n360) );
  GTECH_NOR2 U332 ( .A(n362), .B(n363), .Z(n361) );
  GTECH_NOT U333 ( .A(n364), .Z(n363) );
  GTECH_NOR2 U334 ( .A(n365), .B(n366), .Z(n364) );
  GTECH_NOR2 U335 ( .A(n367), .B(n368), .Z(n366) );
  GTECH_NOR2 U336 ( .A(n319), .B(n369), .Z(n365) );
  GTECH_NOT U337 ( .A(n370), .Z(n369) );
  GTECH_NOR2 U338 ( .A(hready), .B(n371), .Z(n370) );
  GTECH_NOR2 U339 ( .A(n372), .B(n373), .Z(n371) );
  GTECH_NOR2 U340 ( .A(n325), .B(n374), .Z(n373) );
  GTECH_NOR2 U341 ( .A(n375), .B(n376), .Z(n372) );
  GTECH_NOT U342 ( .A(n377), .Z(n376) );
  GTECH_NOR2 U343 ( .A(n378), .B(n379), .Z(n377) );
  GTECH_NOR2 U344 ( .A(bus_priority[11]), .B(n332), .Z(n379) );
  GTECH_NOR2 U345 ( .A(n380), .B(n381), .Z(n378) );
  GTECH_NOT U346 ( .A(n382), .Z(n381) );
  GTECH_NOR2 U347 ( .A(bus_priority[8]), .B(n333), .Z(n382) );
  GTECH_NOR2 U348 ( .A(n383), .B(n380), .Z(n375) );
  GTECH_NOT U349 ( .A(n384), .Z(n380) );
  GTECH_NOR2 U350 ( .A(n385), .B(n386), .Z(n384) );
  GTECH_NOR2 U351 ( .A(n341), .B(n387), .Z(n386) );
  GTECH_NOR2 U352 ( .A(n388), .B(n389), .Z(n385) );
  GTECH_NOT U353 ( .A(n390), .Z(n389) );
  GTECH_NOR2 U354 ( .A(n346), .B(n391), .Z(n390) );
  GTECH_NOR2 U355 ( .A(n391), .B(n392), .Z(n383) );
  GTECH_NOR2 U356 ( .A(bus_priority[9]), .B(n349), .Z(n392) );
  GTECH_NOR2 U357 ( .A(bus_priority[10]), .B(n350), .Z(n391) );
  GTECH_NOR2 U358 ( .A(n313), .B(n393), .Z(n362) );
  GTECH_NOT U359 ( .A(n394), .Z(n393) );
  GTECH_NOR2 U360 ( .A(hready), .B(n395), .Z(n394) );
  GTECH_NOT U361 ( .A(n396), .Z(n359) );
  GTECH_NOR2 U362 ( .A(n397), .B(n398), .Z(n396) );
  GTECH_NOT U363 ( .A(n399), .Z(n398) );
  GTECH_NOR2 U364 ( .A(r_mask_locked[2]), .B(maskmaster[2]), .Z(n399) );
  GTECH_NOT U365 ( .A(n400), .Z(mask[1]) );
  GTECH_NOR2 U366 ( .A(n401), .B(n402), .Z(n400) );
  GTECH_NOT U367 ( .A(n403), .Z(n402) );
  GTECH_NOR2 U368 ( .A(n404), .B(n405), .Z(n403) );
  GTECH_NOT U369 ( .A(n406), .Z(n405) );
  GTECH_NOR2 U370 ( .A(n407), .B(n408), .Z(n406) );
  GTECH_NOR2 U371 ( .A(n367), .B(n409), .Z(n408) );
  GTECH_NOT U372 ( .A(n410), .Z(n367) );
  GTECH_NOR2 U373 ( .A(n356), .B(n353), .Z(n410) );
  GTECH_NOT U374 ( .A(n411), .Z(n356) );
  GTECH_NOR2 U375 ( .A(hmaster_data[2]), .B(n412), .Z(n411) );
  GTECH_NOT U376 ( .A(n413), .Z(n412) );
  GTECH_NOR2 U377 ( .A(hready), .B(hmaster_data[3]), .Z(n413) );
  GTECH_NOR2 U378 ( .A(n319), .B(n414), .Z(n407) );
  GTECH_NOT U379 ( .A(n415), .Z(n414) );
  GTECH_NOR2 U380 ( .A(hready), .B(n416), .Z(n415) );
  GTECH_NOR2 U381 ( .A(n417), .B(n418), .Z(n416) );
  GTECH_NOR2 U382 ( .A(n325), .B(n419), .Z(n418) );
  GTECH_NOT U383 ( .A(bus_priority[7]), .Z(n419) );
  GTECH_NOR2 U384 ( .A(n420), .B(n421), .Z(n417) );
  GTECH_NOT U385 ( .A(n422), .Z(n421) );
  GTECH_NOR2 U386 ( .A(n423), .B(n424), .Z(n422) );
  GTECH_NOR2 U387 ( .A(bus_priority[7]), .B(n332), .Z(n424) );
  GTECH_NOT U388 ( .A(n325), .Z(n332) );
  GTECH_NOR2 U389 ( .A(n318), .B(n425), .Z(n325) );
  GTECH_NOT U390 ( .A(n426), .Z(n425) );
  GTECH_NOR2 U391 ( .A(n427), .B(n428), .Z(n426) );
  GTECH_NOR2 U392 ( .A(hmaster_data[1]), .B(n429), .Z(n428) );
  GTECH_NOR2 U393 ( .A(n430), .B(n431), .Z(n429) );
  GTECH_NOR2 U394 ( .A(hmaster_data[0]), .B(bus_priority[3]), .Z(n431) );
  GTECH_NOR2 U395 ( .A(bus_priority[7]), .B(n432), .Z(n430) );
  GTECH_NOR2 U396 ( .A(n433), .B(n434), .Z(n427) );
  GTECH_NOR2 U397 ( .A(hmaster_data[0]), .B(n374), .Z(n433) );
  GTECH_NOT U398 ( .A(bus_priority[11]), .Z(n374) );
  GTECH_NOR2 U399 ( .A(n435), .B(n436), .Z(n423) );
  GTECH_NOT U400 ( .A(n437), .Z(n436) );
  GTECH_NOR2 U401 ( .A(bus_priority[4]), .B(n333), .Z(n437) );
  GTECH_NOT U402 ( .A(n438), .Z(n333) );
  GTECH_NOR2 U403 ( .A(n318), .B(n439), .Z(n438) );
  GTECH_NOT U404 ( .A(n440), .Z(n439) );
  GTECH_NOR2 U405 ( .A(n441), .B(n442), .Z(n440) );
  GTECH_NOR2 U406 ( .A(hmaster_data[1]), .B(n443), .Z(n442) );
  GTECH_NOR2 U407 ( .A(n444), .B(n445), .Z(n443) );
  GTECH_NOR2 U408 ( .A(hmaster_data[0]), .B(bus_priority[0]), .Z(n445) );
  GTECH_NOR2 U409 ( .A(bus_priority[4]), .B(n432), .Z(n444) );
  GTECH_NOR2 U410 ( .A(n446), .B(n434), .Z(n441) );
  GTECH_NOR2 U411 ( .A(hmaster_data[0]), .B(n447), .Z(n446) );
  GTECH_NOT U412 ( .A(bus_priority[8]), .Z(n447) );
  GTECH_NOR2 U413 ( .A(n448), .B(n435), .Z(n420) );
  GTECH_NOT U414 ( .A(n449), .Z(n435) );
  GTECH_NOR2 U415 ( .A(n450), .B(n451), .Z(n449) );
  GTECH_NOR2 U416 ( .A(n341), .B(n452), .Z(n451) );
  GTECH_NOT U417 ( .A(bus_priority[6]), .Z(n452) );
  GTECH_NOR2 U418 ( .A(n453), .B(n454), .Z(n450) );
  GTECH_NOT U419 ( .A(n455), .Z(n454) );
  GTECH_NOR2 U420 ( .A(n346), .B(n456), .Z(n455) );
  GTECH_NOT U421 ( .A(bus_priority[5]), .Z(n453) );
  GTECH_NOR2 U422 ( .A(n456), .B(n457), .Z(n448) );
  GTECH_NOR2 U423 ( .A(bus_priority[5]), .B(n349), .Z(n457) );
  GTECH_NOT U424 ( .A(n346), .Z(n349) );
  GTECH_NOR2 U425 ( .A(n318), .B(n458), .Z(n346) );
  GTECH_NOT U426 ( .A(n459), .Z(n458) );
  GTECH_NOR2 U427 ( .A(n460), .B(n461), .Z(n459) );
  GTECH_NOR2 U428 ( .A(hmaster_data[1]), .B(n462), .Z(n461) );
  GTECH_NOR2 U429 ( .A(n463), .B(n464), .Z(n462) );
  GTECH_NOR2 U430 ( .A(hmaster_data[0]), .B(bus_priority[1]), .Z(n464) );
  GTECH_NOR2 U431 ( .A(bus_priority[5]), .B(n432), .Z(n463) );
  GTECH_NOR2 U432 ( .A(n465), .B(n434), .Z(n460) );
  GTECH_NOR2 U433 ( .A(hmaster_data[0]), .B(n388), .Z(n465) );
  GTECH_NOT U434 ( .A(bus_priority[9]), .Z(n388) );
  GTECH_NOR2 U435 ( .A(bus_priority[6]), .B(n350), .Z(n456) );
  GTECH_NOT U436 ( .A(n341), .Z(n350) );
  GTECH_NOR2 U437 ( .A(n318), .B(n466), .Z(n341) );
  GTECH_NOT U438 ( .A(n467), .Z(n466) );
  GTECH_NOR2 U439 ( .A(n468), .B(n469), .Z(n467) );
  GTECH_NOR2 U440 ( .A(hmaster_data[1]), .B(n470), .Z(n469) );
  GTECH_NOR2 U441 ( .A(n471), .B(n472), .Z(n470) );
  GTECH_NOR2 U442 ( .A(hmaster_data[0]), .B(bus_priority[2]), .Z(n472) );
  GTECH_NOR2 U443 ( .A(bus_priority[6]), .B(n432), .Z(n471) );
  GTECH_NOR2 U444 ( .A(n473), .B(n434), .Z(n468) );
  GTECH_NOR2 U445 ( .A(hmaster_data[0]), .B(n387), .Z(n473) );
  GTECH_NOT U446 ( .A(bus_priority[10]), .Z(n387) );
  GTECH_NOT U447 ( .A(n474), .Z(n319) );
  GTECH_NOR2 U448 ( .A(ltip), .B(n475), .Z(n474) );
  GTECH_NOR2 U449 ( .A(n313), .B(n476), .Z(n404) );
  GTECH_NOT U450 ( .A(n477), .Z(n476) );
  GTECH_NOR2 U451 ( .A(hready), .B(n478), .Z(n477) );
  GTECH_NOT U452 ( .A(n479), .Z(n313) );
  GTECH_NOR2 U453 ( .A(n475), .B(n480), .Z(n479) );
  GTECH_NOT U454 ( .A(n481), .Z(n475) );
  GTECH_NOR2 U455 ( .A(hresp[0]), .B(n482), .Z(n481) );
  GTECH_NOT U456 ( .A(n483), .Z(n401) );
  GTECH_NOR2 U457 ( .A(n484), .B(n485), .Z(n483) );
  GTECH_NOT U458 ( .A(n486), .Z(n485) );
  GTECH_NOR2 U459 ( .A(r_mask_locked[1]), .B(maskmaster[1]), .Z(n486) );
  GTECH_NOT U460 ( .A(n487), .Z(n602) );
  GTECH_NOR2 U461 ( .A(n397), .B(n488), .Z(n487) );
  GTECH_NOR2 U462 ( .A(n368), .B(n489), .Z(n488) );
  GTECH_NOR2 U463 ( .A(hsplit[2]), .B(n281), .Z(n397) );
  GTECH_NOT U464 ( .A(n490), .Z(n603) );
  GTECH_NOR2 U465 ( .A(n484), .B(n491), .Z(n490) );
  GTECH_NOR2 U466 ( .A(n409), .B(n489), .Z(n491) );
  GTECH_NOT U467 ( .A(n492), .Z(n489) );
  GTECH_NOR2 U468 ( .A(n318), .B(n493), .Z(n492) );
  GTECH_NOT U469 ( .A(n494), .Z(n493) );
  GTECH_NOR2 U470 ( .A(n482), .B(n495), .Z(n494) );
  GTECH_NOT U471 ( .A(n496), .Z(n495) );
  GTECH_NOR2 U472 ( .A(hready), .B(n497), .Z(n496) );
  GTECH_NOR2 U473 ( .A(hsplit[1]), .B(n284), .Z(n484) );
  GTECH_NOT U474 ( .A(n498), .Z(n604) );
  GTECH_NOR2 U475 ( .A(n499), .B(n500), .Z(n498) );
  GTECH_NOR2 U476 ( .A(n395), .B(n501), .Z(n500) );
  GTECH_NOR2 U477 ( .A(n318), .B(n368), .Z(n395) );
  GTECH_NOT U478 ( .A(n502), .Z(n368) );
  GTECH_NOR2 U479 ( .A(hmaster_data[0]), .B(n434), .Z(n502) );
  GTECH_NOT U480 ( .A(hmaster_data[1]), .Z(n434) );
  GTECH_NOR2 U481 ( .A(est), .B(n503), .Z(n499) );
  GTECH_NOT U482 ( .A(r_mask_locked[2]), .Z(n503) );
  GTECH_NOT U483 ( .A(n504), .Z(n605) );
  GTECH_NOR2 U484 ( .A(n505), .B(n506), .Z(n504) );
  GTECH_NOR2 U485 ( .A(n478), .B(n501), .Z(n506) );
  GTECH_NOT U486 ( .A(n507), .Z(n501) );
  GTECH_NOR2 U487 ( .A(n508), .B(n509), .Z(n507) );
  GTECH_NOT U488 ( .A(n510), .Z(n509) );
  GTECH_NOR2 U489 ( .A(csilt), .B(n353), .Z(n510) );
  GTECH_NOT U490 ( .A(n511), .Z(n353) );
  GTECH_NOR2 U491 ( .A(n497), .B(n482), .Z(n511) );
  GTECH_NOT U492 ( .A(hresp[1]), .Z(n482) );
  GTECH_NOT U493 ( .A(hresp[0]), .Z(n497) );
  GTECH_NOT U494 ( .A(n512), .Z(n508) );
  GTECH_NOR2 U495 ( .A(n318), .B(n409), .Z(n478) );
  GTECH_NOT U496 ( .A(n513), .Z(n409) );
  GTECH_NOR2 U497 ( .A(hmaster_data[1]), .B(n432), .Z(n513) );
  GTECH_NOT U498 ( .A(hmaster_data[0]), .Z(n432) );
  GTECH_NOT U499 ( .A(n514), .Z(n318) );
  GTECH_NOR2 U500 ( .A(hmaster_data[3]), .B(hmaster_data[2]), .Z(n514) );
  GTECH_NOR2 U501 ( .A(est), .B(n515), .Z(n505) );
  GTECH_NOT U502 ( .A(r_mask_locked[1]), .Z(n515) );
  GTECH_NOT U503 ( .A(n516), .Z(hsplit[15]) );
  GTECH_NOR2 U504 ( .A(n517), .B(n518), .Z(n516) );
  GTECH_NOT U505 ( .A(n519), .Z(n518) );
  GTECH_NOR2 U506 ( .A(bus_hsplit[31]), .B(bus_hsplit[15]), .Z(n519) );
  GTECH_NOT U507 ( .A(n520), .Z(n517) );
  GTECH_NOR2 U508 ( .A(bus_hsplit[63]), .B(bus_hsplit[47]), .Z(n520) );
  GTECH_NOT U509 ( .A(n521), .Z(hsplit[14]) );
  GTECH_NOR2 U510 ( .A(n522), .B(n523), .Z(n521) );
  GTECH_NOT U511 ( .A(n524), .Z(n523) );
  GTECH_NOR2 U512 ( .A(bus_hsplit[30]), .B(bus_hsplit[14]), .Z(n524) );
  GTECH_NOT U513 ( .A(n525), .Z(n522) );
  GTECH_NOR2 U514 ( .A(bus_hsplit[62]), .B(bus_hsplit[46]), .Z(n525) );
  GTECH_NOT U515 ( .A(n526), .Z(hsplit[13]) );
  GTECH_NOR2 U516 ( .A(n527), .B(n528), .Z(n526) );
  GTECH_NOT U517 ( .A(n529), .Z(n528) );
  GTECH_NOR2 U518 ( .A(bus_hsplit[29]), .B(bus_hsplit[13]), .Z(n529) );
  GTECH_NOT U519 ( .A(n530), .Z(n527) );
  GTECH_NOR2 U520 ( .A(bus_hsplit[61]), .B(bus_hsplit[45]), .Z(n530) );
  GTECH_NOT U521 ( .A(n531), .Z(hsplit[12]) );
  GTECH_NOR2 U522 ( .A(n532), .B(n533), .Z(n531) );
  GTECH_NOT U523 ( .A(n534), .Z(n533) );
  GTECH_NOR2 U524 ( .A(bus_hsplit[28]), .B(bus_hsplit[12]), .Z(n534) );
  GTECH_NOT U525 ( .A(n535), .Z(n532) );
  GTECH_NOR2 U526 ( .A(bus_hsplit[60]), .B(bus_hsplit[44]), .Z(n535) );
  GTECH_NOT U527 ( .A(n536), .Z(hsplit[11]) );
  GTECH_NOR2 U528 ( .A(n537), .B(n538), .Z(n536) );
  GTECH_NOT U529 ( .A(n539), .Z(n538) );
  GTECH_NOR2 U530 ( .A(bus_hsplit[27]), .B(bus_hsplit[11]), .Z(n539) );
  GTECH_NOT U531 ( .A(n540), .Z(n537) );
  GTECH_NOR2 U532 ( .A(bus_hsplit[59]), .B(bus_hsplit[43]), .Z(n540) );
  GTECH_NOT U533 ( .A(n541), .Z(hsplit[10]) );
  GTECH_NOR2 U534 ( .A(n542), .B(n543), .Z(n541) );
  GTECH_NOT U535 ( .A(n544), .Z(n543) );
  GTECH_NOR2 U536 ( .A(bus_hsplit[26]), .B(bus_hsplit[10]), .Z(n544) );
  GTECH_NOT U537 ( .A(n545), .Z(n542) );
  GTECH_NOR2 U538 ( .A(bus_hsplit[58]), .B(bus_hsplit[42]), .Z(n545) );
  GTECH_NOT U539 ( .A(n546), .Z(hsplit[9]) );
  GTECH_NOR2 U540 ( .A(n547), .B(n548), .Z(n546) );
  GTECH_NOT U541 ( .A(n549), .Z(n548) );
  GTECH_NOR2 U542 ( .A(bus_hsplit[41]), .B(bus_hsplit[25]), .Z(n549) );
  GTECH_NOT U543 ( .A(n550), .Z(n547) );
  GTECH_NOR2 U544 ( .A(bus_hsplit[9]), .B(bus_hsplit[57]), .Z(n550) );
  GTECH_NOT U545 ( .A(n551), .Z(hsplit[8]) );
  GTECH_NOR2 U546 ( .A(n552), .B(n553), .Z(n551) );
  GTECH_NOT U547 ( .A(n554), .Z(n553) );
  GTECH_NOR2 U548 ( .A(bus_hsplit[40]), .B(bus_hsplit[24]), .Z(n554) );
  GTECH_NOT U549 ( .A(n555), .Z(n552) );
  GTECH_NOR2 U550 ( .A(bus_hsplit[8]), .B(bus_hsplit[56]), .Z(n555) );
  GTECH_NOT U551 ( .A(n556), .Z(hsplit[7]) );
  GTECH_NOR2 U552 ( .A(n557), .B(n558), .Z(n556) );
  GTECH_NOT U553 ( .A(n559), .Z(n558) );
  GTECH_NOR2 U554 ( .A(bus_hsplit[39]), .B(bus_hsplit[23]), .Z(n559) );
  GTECH_NOT U555 ( .A(n560), .Z(n557) );
  GTECH_NOR2 U556 ( .A(bus_hsplit[7]), .B(bus_hsplit[55]), .Z(n560) );
  GTECH_NOT U557 ( .A(n561), .Z(hsplit[6]) );
  GTECH_NOR2 U558 ( .A(n562), .B(n563), .Z(n561) );
  GTECH_NOT U559 ( .A(n564), .Z(n563) );
  GTECH_NOR2 U560 ( .A(bus_hsplit[38]), .B(bus_hsplit[22]), .Z(n564) );
  GTECH_NOT U561 ( .A(n565), .Z(n562) );
  GTECH_NOR2 U562 ( .A(bus_hsplit[6]), .B(bus_hsplit[54]), .Z(n565) );
  GTECH_NOT U563 ( .A(n566), .Z(hsplit[5]) );
  GTECH_NOR2 U564 ( .A(n567), .B(n568), .Z(n566) );
  GTECH_NOT U565 ( .A(n569), .Z(n568) );
  GTECH_NOR2 U566 ( .A(bus_hsplit[37]), .B(bus_hsplit[21]), .Z(n569) );
  GTECH_NOT U567 ( .A(n570), .Z(n567) );
  GTECH_NOR2 U568 ( .A(bus_hsplit[5]), .B(bus_hsplit[53]), .Z(n570) );
  GTECH_NOT U569 ( .A(n571), .Z(hsplit[4]) );
  GTECH_NOR2 U570 ( .A(n572), .B(n573), .Z(n571) );
  GTECH_NOT U571 ( .A(n574), .Z(n573) );
  GTECH_NOR2 U572 ( .A(bus_hsplit[36]), .B(bus_hsplit[20]), .Z(n574) );
  GTECH_NOT U573 ( .A(n575), .Z(n572) );
  GTECH_NOR2 U574 ( .A(bus_hsplit[52]), .B(bus_hsplit[4]), .Z(n575) );
  GTECH_NOT U575 ( .A(n576), .Z(hsplit[3]) );
  GTECH_NOR2 U576 ( .A(n577), .B(n578), .Z(n576) );
  GTECH_NOT U577 ( .A(n579), .Z(n578) );
  GTECH_NOR2 U578 ( .A(bus_hsplit[35]), .B(bus_hsplit[19]), .Z(n579) );
  GTECH_NOT U579 ( .A(n580), .Z(n577) );
  GTECH_NOR2 U580 ( .A(bus_hsplit[51]), .B(bus_hsplit[3]), .Z(n580) );
  GTECH_NOT U581 ( .A(n581), .Z(hsplit[2]) );
  GTECH_NOR2 U582 ( .A(n582), .B(n583), .Z(n581) );
  GTECH_NOT U583 ( .A(n584), .Z(n583) );
  GTECH_NOR2 U584 ( .A(bus_hsplit[2]), .B(bus_hsplit[18]), .Z(n584) );
  GTECH_NOT U585 ( .A(n585), .Z(n582) );
  GTECH_NOR2 U586 ( .A(bus_hsplit[50]), .B(bus_hsplit[34]), .Z(n585) );
  GTECH_NOT U587 ( .A(n586), .Z(hsplit[1]) );
  GTECH_NOR2 U588 ( .A(n587), .B(n588), .Z(n586) );
  GTECH_NOT U589 ( .A(n589), .Z(n588) );
  GTECH_NOR2 U590 ( .A(bus_hsplit[1]), .B(bus_hsplit[17]), .Z(n589) );
  GTECH_NOT U591 ( .A(n590), .Z(n587) );
  GTECH_NOR2 U592 ( .A(bus_hsplit[49]), .B(bus_hsplit[33]), .Z(n590) );
  GTECH_NOT U593 ( .A(n591), .Z(hsplit[0]) );
  GTECH_NOR2 U594 ( .A(n592), .B(n593), .Z(n591) );
  GTECH_NOT U595 ( .A(n594), .Z(n593) );
  GTECH_NOR2 U596 ( .A(bus_hsplit[16]), .B(bus_hsplit[0]), .Z(n594) );
  GTECH_NOT U597 ( .A(n595), .Z(n592) );
  GTECH_NOR2 U598 ( .A(bus_hsplit[48]), .B(bus_hsplit[32]), .Z(n595) );
  GTECH_NOT U599 ( .A(n596), .Z(n622) );
  GTECH_NOR2 U600 ( .A(n512), .B(n597), .Z(n596) );
  GTECH_NOR2 U601 ( .A(n480), .B(n598), .Z(n597) );
  GTECH_NOT U602 ( .A(hready), .Z(n598) );
  GTECH_NOT U603 ( .A(ltip), .Z(n480) );
  GTECH_NOR2 U604 ( .A(n287), .B(hready), .Z(n512) );
endmodule


module DW_ahb_gctrl ( hclk, hresetn, ahb_sc_arb, hburst, hready, hresp, hsplit, 
        htrans, bus_hlock, def_mst, pause, grant_2t, parked_2t, mask, set_ebt, 
        bus_hbusreq, grant_changed, ibus_hbusreq, ltip, csilt, bus_hgrant, 
        hmastlock, hmaster, new_tfr, est );
  input [2:0] hburst;
  input [1:0] hresp;
  input [15:0] hsplit;
  input [1:0] htrans;
  input [2:0] bus_hlock;
  input [3:0] def_mst;
  input [2:0] grant_2t;
  input [2:0] mask;
  input [2:0] bus_hbusreq;
  output [2:0] ibus_hbusreq;
  output [2:0] bus_hgrant;
  output [3:0] hmaster;
  input hclk, hresetn, ahb_sc_arb, hready, pause, parked_2t, set_ebt;
  output grant_changed, ltip, csilt, hmastlock, new_tfr, est;
  wire   hgrant_previous_0_, n576, n582, n583, n584, n585, n592, n593, n594,
         n595, n596, n597, n598, n599, n600, n601, n602, n603, n604, n605,
         n606, n607, n608, n609, n610, n611, n612, n613, n614, n615, n616,
         n617, n618, n619, n620, n621, n622, n623, n624, n625, n626, n627,
         n628, n629, n630, n631, n632, n633, n634, n635, n636, n637, n638,
         n639, n640, n641, n642, n643, n644, n645, n646, n647, n648, n649,
         n650, n651, n652, n653, n654, n655, n656, n657, n658, n659, n660,
         n661, n662, n663, n664, n665, n666, n667, n668, n669, n670, n671,
         n672, n673, n674, n675, n676, n677, n678, n679, n680, n681, n682,
         n683, n684, n685, n686, n687, n688, n689, n690, n691, n692, n693,
         n694, n695, n696, n697, n698, n699, n700, n701, n702, n703, n704,
         n705, n706, n707, n708, n709, n710, n711, n712, n713, n714, n715,
         n716, n717, n718, n719, n720, n721, n722, n723, n724, n725, n726,
         n727, n728, n729, n730, n731, n732, n733, n734, n735, n736, n737,
         n738, n739, n740, n741, n742, n743, n744, n745, n746, n747, n748,
         n749, n750, n751, n752, n753, n754, n755, n756, n757, n758, n759,
         n760, n761, n762, n763, n764, n765, n766, n767, n768, n769, n770,
         n771, n772, n773, n774, n775, n776, n777, n778, n779, n780, n781,
         n782, n783, n784, n785, n786, n787, n788, n789, n790, n791, n792,
         n793, n794, n795, n796, n797, n798, n799, n800, n801, n802, n803,
         n804, n805, n806, n807, n808, n809, n810, n811, n812, n813, n814,
         n815, n816, n817, n818, n819, n820, n821, n822, n823, n824, n825,
         n826, n827, n828, n829, n830, n831, n832, n833, n834, n835, n836,
         n837, n838, n839, n840, n841, n842, n843, n844, n845, n846, n847,
         n848, n849, n850, n851, n852, n853, n854, n855, n856, n857, n858,
         n859, n860, n861, n862, n863, n864, n865, n866, n867, n868, n869,
         n870, n871, n872, n873, n874, n875, n876, n877, n878, n879, n880,
         n881, n882, n883, n884, n885, n886, n887, n888, n889, n890, n891,
         n892, n893, n894, n895, n896, n897, n898, n899, n900, n901, n902,
         n903, n904, n905, n906, n907, n908, n909, n910, n911, n912, n913,
         n914, n915, n916, n917, n918, n919, n920, n921, n922, n923, n924,
         n925, n926, n927, n928, n929, n930, n931, n932, n933, n934, n935,
         n936, n937, n938, n939, n940, n941, n942, n943, n944, n945, n946,
         n947, n948, n949, n950, n951, n952, n953, n954, n955, n956, n957,
         n958, n959, n960, n961, n962, n963, n964, n965, n966, n967, n968,
         n969, n970, n971, n972, n973, n974, n975, n976, n977, n978, n979,
         n980, n981, n982, n983, n984, n985, n986, n987, n988, n989, n990,
         n991, n992, n993, n994, n995, n996, n997, n998, n999, n1000, n1001,
         n1002, n1003, n1004, n1005, n1006, n1007, n1008, n1009, n1010, n1011,
         n1012, n1013, n1014, n1015, n1016, n1017, n1018, n1019, n1020, n1021,
         n1022, n1023, n1024, n1025, n1026, n1027, n1028, n1029, n1030, n1031,
         n1032, n1033, n1034, n1035, n1036, n1037, n1038, n1039, n1040, n1041,
         n1042, n1043, n1044, n1045, n1046, n1047, n1048, n1049, n1050, n1051,
         n1052, n1053, n1054, n1055, n1056, n1057, n1058, n1059, n1060, n1061,
         n1062, n1063, n1064, n1065, n1066, n1067, n1068, n1069, n1070, n1071,
         n1072, n1073, n1074, n1075, n1076, n1077, n1078, n1079, n1080, n1081,
         n1082, n1083, n1084, n1085, n1086, n1087, n1088, n1089, n1090, n1091,
         n1092, n1093, n1094, n1095, n1096, n1097, n1098, n1099, n1100, n1101,
         n1102, n1103, n1104, n1105, n1106, n1107, n1108, n1109, n1110, n1111,
         n1112, n1113, n1114, n1115, n1116, n1117, n1118, n1119, n1121, n1122,
         n1123, n1124, n1125, n1127, n1129, n1130, n1131, n1132, n1133, n1134,
         n1135, n1136, n1137, n1138, n1139, n1140, n1141, n1142, n1143, n1144,
         n1145, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156, n1158,
         n1159, n1160, n1161, n1162;
  wire   [1:0] r_hmaster_d;
  assign hmaster[3] = 1'b0;
  assign hmaster[2] = 1'b0;

  GTECH_FD2 bbc_reg_0_ ( .D(n1150), .CP(hclk), .CD(hresetn), .Q(n1137) );
  GTECH_FD2 bbc_reg_1_ ( .D(n1151), .CP(hclk), .CD(hresetn), .Q(n1136) );
  GTECH_FD2 bbc_reg_2_ ( .D(n1149), .CP(hclk), .CD(hresetn), .Q(n1135) );
  GTECH_FD2 bbc_reg_3_ ( .D(n1145), .CP(hclk), .CD(hresetn), .Q(n1134) );
  GTECH_FD2 csilt_reg ( .D(n1159), .CP(hclk), .CD(hresetn), .Q(csilt), .QN(
        n592) );
  GTECH_FD2 lock_sm_reg_0_ ( .D(n1158), .CP(hclk), .CD(hresetn), .Q(n1133) );
  GTECH_FD2 ihmastlock_reg ( .D(n593), .CP(hclk), .CD(hresetn), .Q(hmastlock)
         );
  GTECH_FD2 lock_sm_reg_1_ ( .D(n1161), .CP(hclk), .CD(hresetn), .Q(n1132) );
  GTECH_FD2 lock_sm_reg_2_ ( .D(n1160), .CP(hclk), .CD(hresetn), .Q(n1131) );
  GTECH_FD2 wasinn_reg ( .D(n1156), .CP(hclk), .CD(hresetn), .QN(n1130) );
  GTECH_FD2 bus_hgrant_reg_2_ ( .D(n1140), .CP(hclk), .CD(hresetn), .Q(
        bus_hgrant[2]), .QN(n576) );
  GTECH_FD4 hgrant_previous_reg_2_ ( .D(bus_hgrant[2]), .CP(hclk), .SD(hresetn), .Q(n1129) );
  GTECH_FD4 bus_hgrant_reg_0_ ( .D(n1138), .CP(hclk), .SD(hresetn), .Q(
        bus_hgrant[0]), .QN(n583) );
  GTECH_FD4 hgrant_previous_reg_0_ ( .D(bus_hgrant[0]), .CP(hclk), .SD(hresetn), .Q(hgrant_previous_0_) );
  GTECH_FD2 r_hmaster_reg_0_ ( .D(n1155), .CP(hclk), .CD(hresetn), .Q(
        hmaster[0]), .QN(n585) );
  GTECH_FD2 r_hmaster_d_reg_0_ ( .D(n1154), .CP(hclk), .CD(hresetn), .Q(
        r_hmaster_d[0]) );
  GTECH_FD2 bus_hgrant_reg_1_ ( .D(n1139), .CP(hclk), .CD(hresetn), .Q(
        bus_hgrant[1]), .QN(n582) );
  GTECH_FD4 hgrant_previous_reg_1_ ( .D(bus_hgrant[1]), .CP(hclk), .SD(hresetn), .Q(n1127) );
  GTECH_FD2 r_hmaster_reg_1_ ( .D(n1153), .CP(hclk), .CD(hresetn), .Q(
        hmaster[1]), .QN(n584) );
  GTECH_FD2 r_hmaster_d_reg_1_ ( .D(n1152), .CP(hclk), .CD(hresetn), .Q(
        r_hmaster_d[1]) );
  GTECH_FD2 ihlock_reg ( .D(n1162), .CP(hclk), .CD(hresetn), .Q(n1125) );
  GTECH_FD2 bc_reg_2_ ( .D(n1141), .CP(hclk), .CD(hresetn), .Q(n1124) );
  GTECH_FD2 bc_reg_3_ ( .D(n1142), .CP(hclk), .CD(hresetn), .Q(n1123) );
  GTECH_FD2 bc_reg_0_ ( .D(n1144), .CP(hclk), .CD(hresetn), .Q(n1122) );
  GTECH_FD2 bc_reg_1_ ( .D(n1143), .CP(hclk), .CD(hresetn), .Q(n1121) );
  GTECH_NOT U558 ( .A(n594), .Z(n1138) );
  GTECH_NOR2 U559 ( .A(n595), .B(n596), .Z(n594) );
  GTECH_NOT U560 ( .A(n597), .Z(n596) );
  GTECH_NOR2 U561 ( .A(n598), .B(n599), .Z(n597) );
  GTECH_NOR2 U562 ( .A(n600), .B(n601), .Z(n599) );
  GTECH_NOR2 U563 ( .A(n602), .B(n603), .Z(n601) );
  GTECH_NOT U564 ( .A(n604), .Z(n603) );
  GTECH_NOR2 U565 ( .A(n605), .B(n606), .Z(n604) );
  GTECH_NOR2 U566 ( .A(n607), .B(n608), .Z(n606) );
  GTECH_NOR2 U567 ( .A(n609), .B(n610), .Z(n607) );
  GTECH_NOT U568 ( .A(n611), .Z(n610) );
  GTECH_NOR2 U569 ( .A(n612), .B(n613), .Z(n611) );
  GTECH_NOR2 U570 ( .A(n614), .B(n615), .Z(n613) );
  GTECH_NOT U571 ( .A(n616), .Z(n615) );
  GTECH_NOR2 U572 ( .A(n617), .B(n618), .Z(n612) );
  GTECH_NOT U573 ( .A(n619), .Z(n618) );
  GTECH_NOR2 U574 ( .A(r_hmaster_d[1]), .B(r_hmaster_d[0]), .Z(n619) );
  GTECH_NOR2 U575 ( .A(n620), .B(n621), .Z(n609) );
  GTECH_NOT U576 ( .A(n622), .Z(n621) );
  GTECH_NOR2 U577 ( .A(def_mst[0]), .B(n623), .Z(n622) );
  GTECH_NOR2 U578 ( .A(n624), .B(n625), .Z(n605) );
  GTECH_NOT U579 ( .A(grant_2t[0]), .Z(n625) );
  GTECH_NOR2 U580 ( .A(n583), .B(n626), .Z(n595) );
  GTECH_NOT U581 ( .A(n627), .Z(n1139) );
  GTECH_NOR2 U582 ( .A(n628), .B(n629), .Z(n627) );
  GTECH_NOR2 U583 ( .A(n630), .B(n631), .Z(n629) );
  GTECH_NOR2 U584 ( .A(n632), .B(n633), .Z(n631) );
  GTECH_NOR2 U585 ( .A(n634), .B(n608), .Z(n633) );
  GTECH_NOR2 U586 ( .A(n635), .B(n636), .Z(n634) );
  GTECH_NOR2 U587 ( .A(n617), .B(n637), .Z(n636) );
  GTECH_NOT U588 ( .A(n638), .Z(n637) );
  GTECH_NOR2 U589 ( .A(r_hmaster_d[1]), .B(n639), .Z(n638) );
  GTECH_NOR2 U590 ( .A(n620), .B(n640), .Z(n635) );
  GTECH_NOT U591 ( .A(n641), .Z(n640) );
  GTECH_NOR2 U592 ( .A(n642), .B(n623), .Z(n641) );
  GTECH_NOT U593 ( .A(n643), .Z(n623) );
  GTECH_NOR2 U594 ( .A(def_mst[1]), .B(n644), .Z(n643) );
  GTECH_NOR2 U595 ( .A(n624), .B(n645), .Z(n632) );
  GTECH_NOT U596 ( .A(grant_2t[1]), .Z(n645) );
  GTECH_NOR2 U597 ( .A(n582), .B(n626), .Z(n628) );
  GTECH_NOT U598 ( .A(n646), .Z(n1140) );
  GTECH_NOR2 U599 ( .A(n647), .B(n648), .Z(n646) );
  GTECH_NOR2 U600 ( .A(n630), .B(n649), .Z(n648) );
  GTECH_NOR2 U601 ( .A(n650), .B(n651), .Z(n649) );
  GTECH_NOR2 U602 ( .A(n652), .B(n608), .Z(n651) );
  GTECH_NOT U603 ( .A(n653), .Z(n608) );
  GTECH_NOR2 U604 ( .A(n602), .B(n654), .Z(n653) );
  GTECH_NOT U605 ( .A(parked_2t), .Z(n654) );
  GTECH_NOR2 U606 ( .A(n655), .B(n656), .Z(n652) );
  GTECH_NOR2 U607 ( .A(n617), .B(n657), .Z(n656) );
  GTECH_NOT U608 ( .A(n658), .Z(n657) );
  GTECH_NOR2 U609 ( .A(r_hmaster_d[0]), .B(n659), .Z(n658) );
  GTECH_NOT U610 ( .A(n614), .Z(n617) );
  GTECH_NOR2 U611 ( .A(n660), .B(n661), .Z(n655) );
  GTECH_NOT U612 ( .A(n662), .Z(n661) );
  GTECH_NOR2 U613 ( .A(n644), .B(n620), .Z(n662) );
  GTECH_NOT U614 ( .A(n663), .Z(n620) );
  GTECH_NOR2 U615 ( .A(n616), .B(n614), .Z(n663) );
  GTECH_NOR2 U616 ( .A(n664), .B(n665), .Z(n614) );
  GTECH_NOT U617 ( .A(n666), .Z(n665) );
  GTECH_NOR2 U618 ( .A(hresp[0]), .B(hready), .Z(n666) );
  GTECH_NOR2 U619 ( .A(n667), .B(n644), .Z(n616) );
  GTECH_NOT U620 ( .A(n668), .Z(n667) );
  GTECH_NOR2 U621 ( .A(n669), .B(n670), .Z(n668) );
  GTECH_NOR2 U622 ( .A(mask[1]), .B(def_mst[1]), .Z(n670) );
  GTECH_NOR2 U623 ( .A(n671), .B(n672), .Z(n669) );
  GTECH_NOR2 U624 ( .A(def_mst[0]), .B(n673), .Z(n671) );
  GTECH_NOT U625 ( .A(mask[2]), .Z(n673) );
  GTECH_NOT U626 ( .A(n674), .Z(n644) );
  GTECH_NOR2 U627 ( .A(def_mst[3]), .B(def_mst[2]), .Z(n674) );
  GTECH_NOT U628 ( .A(n675), .Z(n660) );
  GTECH_NOR2 U629 ( .A(def_mst[0]), .B(n672), .Z(n675) );
  GTECH_NOR2 U630 ( .A(n624), .B(n676), .Z(n650) );
  GTECH_NOT U631 ( .A(grant_2t[2]), .Z(n676) );
  GTECH_NOT U632 ( .A(n677), .Z(n624) );
  GTECH_NOR2 U633 ( .A(parked_2t), .B(n602), .Z(n677) );
  GTECH_NOT U634 ( .A(n678), .Z(n602) );
  GTECH_NOR2 U635 ( .A(n679), .B(n680), .Z(n678) );
  GTECH_NOT U636 ( .A(n681), .Z(n680) );
  GTECH_NOR2 U637 ( .A(pause), .B(n598), .Z(n681) );
  GTECH_NOR2 U638 ( .A(n682), .B(n683), .Z(n679) );
  GTECH_NOT U639 ( .A(n684), .Z(n683) );
  GTECH_NOR2 U640 ( .A(hready), .B(n685), .Z(n684) );
  GTECH_NOR2 U641 ( .A(n576), .B(n626), .Z(n647) );
  GTECH_NOT U642 ( .A(n630), .Z(n626) );
  GTECH_NOR2 U643 ( .A(n598), .B(n686), .Z(n630) );
  GTECH_NOT U644 ( .A(n600), .Z(n686) );
  GTECH_NOR2 U645 ( .A(n687), .B(n688), .Z(n600) );
  GTECH_NOT U646 ( .A(n689), .Z(n688) );
  GTECH_NOR2 U647 ( .A(n690), .B(n691), .Z(n689) );
  GTECH_NOR2 U648 ( .A(n692), .B(n693), .Z(n691) );
  GTECH_NOT U649 ( .A(n694), .Z(n693) );
  GTECH_NOR2 U650 ( .A(n695), .B(n696), .Z(n694) );
  GTECH_NOT U651 ( .A(ahb_sc_arb), .Z(n692) );
  GTECH_NOR2 U652 ( .A(n697), .B(n698), .Z(n690) );
  GTECH_NOT U653 ( .A(n699), .Z(n698) );
  GTECH_NOR2 U654 ( .A(grant_changed), .B(n700), .Z(n699) );
  GTECH_NOR2 U655 ( .A(n701), .B(n702), .Z(n700) );
  GTECH_NOR2 U656 ( .A(n703), .B(n704), .Z(n701) );
  GTECH_NOT U657 ( .A(n705), .Z(n704) );
  GTECH_NOR2 U658 ( .A(n706), .B(n707), .Z(n705) );
  GTECH_NOT U659 ( .A(n708), .Z(n703) );
  GTECH_NOR2 U660 ( .A(n709), .B(n710), .Z(n708) );
  GTECH_NOT U661 ( .A(n711), .Z(n710) );
  GTECH_NOR2 U662 ( .A(n712), .B(n713), .Z(n711) );
  GTECH_NOT U663 ( .A(n714), .Z(n697) );
  GTECH_NOR2 U664 ( .A(n715), .B(n716), .Z(n714) );
  GTECH_NOR2 U665 ( .A(n685), .B(n717), .Z(n716) );
  GTECH_NOR2 U666 ( .A(n718), .B(n719), .Z(n717) );
  GTECH_NOT U667 ( .A(n720), .Z(n719) );
  GTECH_NOR2 U668 ( .A(n721), .B(n682), .Z(n720) );
  GTECH_NOR2 U669 ( .A(n1133), .B(n722), .Z(n721) );
  GTECH_NOR2 U670 ( .A(ltip), .B(n723), .Z(n715) );
  GTECH_NOT U671 ( .A(n724), .Z(n723) );
  GTECH_NOR2 U672 ( .A(htrans[1]), .B(n702), .Z(n724) );
  GTECH_NOR2 U673 ( .A(n725), .B(n726), .Z(n702) );
  GTECH_NOT U674 ( .A(n727), .Z(n726) );
  GTECH_NOR2 U675 ( .A(n707), .B(n728), .Z(n727) );
  GTECH_NOT U676 ( .A(n712), .Z(n728) );
  GTECH_NOT U677 ( .A(n729), .Z(n707) );
  GTECH_NOT U678 ( .A(n730), .Z(n725) );
  GTECH_NOR2 U679 ( .A(n706), .B(n731), .Z(n730) );
  GTECH_NOT U680 ( .A(n732), .Z(n731) );
  GTECH_NOR2 U681 ( .A(n733), .B(n709), .Z(n732) );
  GTECH_NOT U682 ( .A(n734), .Z(n709) );
  GTECH_NOR2 U683 ( .A(n735), .B(n736), .Z(n733) );
  GTECH_NOT U684 ( .A(n737), .Z(n736) );
  GTECH_NOR2 U685 ( .A(n738), .B(n739), .Z(n737) );
  GTECH_NOT U686 ( .A(n740), .Z(n735) );
  GTECH_NOR2 U687 ( .A(hresp[1]), .B(hresp[0]), .Z(n740) );
  GTECH_NOT U688 ( .A(n741), .Z(n706) );
  GTECH_NOT U689 ( .A(n742), .Z(n687) );
  GTECH_NOR2 U690 ( .A(pause), .B(n743), .Z(n742) );
  GTECH_NOT U691 ( .A(n744), .Z(n1141) );
  GTECH_NOR2 U692 ( .A(n745), .B(n746), .Z(n744) );
  GTECH_NOR2 U693 ( .A(n734), .B(n747), .Z(n746) );
  GTECH_NOR2 U694 ( .A(n748), .B(n749), .Z(n734) );
  GTECH_NOT U695 ( .A(n750), .Z(n749) );
  GTECH_NOR2 U696 ( .A(n751), .B(n752), .Z(n750) );
  GTECH_NOR2 U697 ( .A(n753), .B(n754), .Z(n752) );
  GTECH_NOT U698 ( .A(n755), .Z(n754) );
  GTECH_NOR2 U699 ( .A(htrans[0]), .B(hburst[1]), .Z(n755) );
  GTECH_NOR2 U700 ( .A(n756), .B(n757), .Z(n748) );
  GTECH_NOR2 U701 ( .A(n758), .B(n759), .Z(n756) );
  GTECH_NOR2 U702 ( .A(n760), .B(n761), .Z(n758) );
  GTECH_NOR2 U703 ( .A(n762), .B(n761), .Z(n745) );
  GTECH_NOT U704 ( .A(n1124), .Z(n761) );
  GTECH_NOT U705 ( .A(n763), .Z(n1142) );
  GTECH_NOR2 U706 ( .A(n764), .B(n765), .Z(n763) );
  GTECH_NOR2 U707 ( .A(n741), .B(n747), .Z(n765) );
  GTECH_NOR2 U708 ( .A(n766), .B(n751), .Z(n741) );
  GTECH_NOR2 U709 ( .A(n767), .B(n768), .Z(n751) );
  GTECH_NOT U710 ( .A(n769), .Z(n767) );
  GTECH_NOR2 U711 ( .A(n770), .B(n771), .Z(n766) );
  GTECH_NOT U712 ( .A(n772), .Z(n771) );
  GTECH_NOR2 U713 ( .A(n759), .B(n757), .Z(n772) );
  GTECH_NOR2 U714 ( .A(n1124), .B(n773), .Z(n759) );
  GTECH_NOT U715 ( .A(n760), .Z(n773) );
  GTECH_NOR2 U716 ( .A(n762), .B(n770), .Z(n764) );
  GTECH_NOT U717 ( .A(n1123), .Z(n770) );
  GTECH_NOT U718 ( .A(n774), .Z(n1143) );
  GTECH_NOR2 U719 ( .A(n775), .B(n776), .Z(n774) );
  GTECH_NOR2 U720 ( .A(n729), .B(n747), .Z(n776) );
  GTECH_NOR2 U721 ( .A(n769), .B(n777), .Z(n729) );
  GTECH_NOR2 U722 ( .A(n778), .B(n757), .Z(n777) );
  GTECH_NOR2 U723 ( .A(n779), .B(n760), .Z(n778) );
  GTECH_NOR2 U724 ( .A(n1121), .B(n1122), .Z(n760) );
  GTECH_NOR2 U725 ( .A(n780), .B(n781), .Z(n779) );
  GTECH_NOR2 U726 ( .A(n762), .B(n781), .Z(n775) );
  GTECH_NOT U727 ( .A(n1121), .Z(n781) );
  GTECH_NOT U728 ( .A(n782), .Z(n1144) );
  GTECH_NOR2 U729 ( .A(n783), .B(n784), .Z(n782) );
  GTECH_NOR2 U730 ( .A(n712), .B(n747), .Z(n784) );
  GTECH_NOR2 U731 ( .A(n769), .B(n785), .Z(n712) );
  GTECH_NOR2 U732 ( .A(n1122), .B(n757), .Z(n785) );
  GTECH_NOT U733 ( .A(n786), .Z(n757) );
  GTECH_NOR2 U734 ( .A(n753), .B(n787), .Z(n786) );
  GTECH_NOT U735 ( .A(n788), .Z(n787) );
  GTECH_NOR2 U736 ( .A(n789), .B(n790), .Z(n788) );
  GTECH_NOR2 U737 ( .A(n1124), .B(n791), .Z(n789) );
  GTECH_NOT U738 ( .A(n792), .Z(n791) );
  GTECH_NOR2 U739 ( .A(n1121), .B(n1123), .Z(n792) );
  GTECH_NOR2 U740 ( .A(htrans[0]), .B(n753), .Z(n769) );
  GTECH_NOT U741 ( .A(n793), .Z(n753) );
  GTECH_NOR2 U742 ( .A(n794), .B(n795), .Z(n793) );
  GTECH_NOT U743 ( .A(n796), .Z(n795) );
  GTECH_NOR2 U744 ( .A(n598), .B(n797), .Z(n796) );
  GTECH_NOR2 U745 ( .A(htrans[0]), .B(htrans[1]), .Z(n797) );
  GTECH_NOR2 U746 ( .A(n798), .B(n799), .Z(n598) );
  GTECH_NOT U747 ( .A(n800), .Z(n799) );
  GTECH_NOR2 U748 ( .A(ltip), .B(grant_changed), .Z(n800) );
  GTECH_NOT U749 ( .A(set_ebt), .Z(n798) );
  GTECH_NOT U750 ( .A(n801), .Z(n794) );
  GTECH_NOR2 U751 ( .A(n802), .B(n803), .Z(n801) );
  GTECH_NOT U752 ( .A(n804), .Z(n803) );
  GTECH_NOR2 U753 ( .A(ahb_sc_arb), .B(n738), .Z(n804) );
  GTECH_NOR2 U754 ( .A(hready), .B(n664), .Z(n802) );
  GTECH_NOR2 U755 ( .A(n762), .B(n780), .Z(n783) );
  GTECH_NOT U756 ( .A(n1122), .Z(n780) );
  GTECH_NOT U757 ( .A(n805), .Z(n1145) );
  GTECH_NOR2 U758 ( .A(n806), .B(n807), .Z(n805) );
  GTECH_NOR2 U759 ( .A(n747), .B(n808), .Z(n807) );
  GTECH_NOT U760 ( .A(n809), .Z(n808) );
  GTECH_NOR2 U761 ( .A(n762), .B(n810), .Z(n806) );
  GTECH_NOT U762 ( .A(n811), .Z(ibus_hbusreq[2]) );
  GTECH_NOR2 U763 ( .A(bus_hbusreq[2]), .B(n812), .Z(n811) );
  GTECH_NOR2 U764 ( .A(n813), .B(n814), .Z(n812) );
  GTECH_NOT U765 ( .A(n815), .Z(n814) );
  GTECH_NOR2 U766 ( .A(n584), .B(n816), .Z(n815) );
  GTECH_NOT U767 ( .A(n817), .Z(ibus_hbusreq[1]) );
  GTECH_NOR2 U768 ( .A(bus_hbusreq[1]), .B(n818), .Z(n817) );
  GTECH_NOR2 U769 ( .A(n819), .B(n820), .Z(n818) );
  GTECH_NOT U770 ( .A(n821), .Z(n820) );
  GTECH_NOR2 U771 ( .A(n585), .B(n816), .Z(n821) );
  GTECH_NOT U772 ( .A(n822), .Z(ibus_hbusreq[0]) );
  GTECH_NOR2 U773 ( .A(bus_hbusreq[0]), .B(n823), .Z(n822) );
  GTECH_NOR2 U774 ( .A(n819), .B(n824), .Z(n823) );
  GTECH_NOT U775 ( .A(n825), .Z(n824) );
  GTECH_NOR2 U776 ( .A(n816), .B(n813), .Z(n825) );
  GTECH_NOR2 U777 ( .A(n809), .B(n826), .Z(n816) );
  GTECH_NOT U778 ( .A(n827), .Z(n826) );
  GTECH_NOR2 U779 ( .A(n828), .B(n829), .Z(n827) );
  GTECH_NOR2 U780 ( .A(n738), .B(n830), .Z(n809) );
  GTECH_NOR2 U781 ( .A(n831), .B(n832), .Z(n830) );
  GTECH_NOT U782 ( .A(n833), .Z(n832) );
  GTECH_NOR2 U783 ( .A(n834), .B(n835), .Z(n833) );
  GTECH_NOR2 U784 ( .A(n768), .B(n836), .Z(n835) );
  GTECH_NOT U785 ( .A(n837), .Z(n768) );
  GTECH_NOR2 U786 ( .A(n838), .B(n739), .Z(n834) );
  GTECH_NOR2 U787 ( .A(n839), .B(n840), .Z(n838) );
  GTECH_NOR2 U788 ( .A(n1134), .B(n841), .Z(n840) );
  GTECH_NOT U789 ( .A(n842), .Z(n841) );
  GTECH_NOR2 U790 ( .A(n842), .B(n810), .Z(n839) );
  GTECH_NOR2 U791 ( .A(n810), .B(n843), .Z(n831) );
  GTECH_NOT U792 ( .A(n1134), .Z(n810) );
  GTECH_NOT U793 ( .A(n844), .Z(n1149) );
  GTECH_NOR2 U794 ( .A(n845), .B(n846), .Z(n844) );
  GTECH_NOR2 U795 ( .A(n747), .B(n847), .Z(n846) );
  GTECH_NOT U796 ( .A(n829), .Z(n847) );
  GTECH_NOR2 U797 ( .A(n738), .B(n848), .Z(n829) );
  GTECH_NOR2 U798 ( .A(n849), .B(n850), .Z(n848) );
  GTECH_NOT U799 ( .A(n851), .Z(n850) );
  GTECH_NOR2 U800 ( .A(n852), .B(n853), .Z(n851) );
  GTECH_NOR2 U801 ( .A(n854), .B(n836), .Z(n853) );
  GTECH_NOT U802 ( .A(n855), .Z(n836) );
  GTECH_NOR2 U803 ( .A(n837), .B(n856), .Z(n854) );
  GTECH_NOR2 U804 ( .A(n856), .B(n857), .Z(n837) );
  GTECH_NOT U805 ( .A(hburst[2]), .Z(n857) );
  GTECH_NOT U806 ( .A(hburst[1]), .Z(n856) );
  GTECH_NOR2 U807 ( .A(n858), .B(n739), .Z(n852) );
  GTECH_NOR2 U808 ( .A(n859), .B(n842), .Z(n858) );
  GTECH_NOR2 U809 ( .A(n1135), .B(n860), .Z(n842) );
  GTECH_NOT U810 ( .A(n861), .Z(n860) );
  GTECH_NOR2 U811 ( .A(n861), .B(n862), .Z(n859) );
  GTECH_NOR2 U812 ( .A(n843), .B(n862), .Z(n849) );
  GTECH_NOR2 U813 ( .A(n762), .B(n862), .Z(n845) );
  GTECH_NOT U814 ( .A(n1135), .Z(n862) );
  GTECH_NOT U815 ( .A(n863), .Z(n1150) );
  GTECH_NOR2 U816 ( .A(n864), .B(n865), .Z(n863) );
  GTECH_NOR2 U817 ( .A(n747), .B(n866), .Z(n865) );
  GTECH_NOT U818 ( .A(n867), .Z(n866) );
  GTECH_NOR2 U819 ( .A(n738), .B(n868), .Z(n867) );
  GTECH_NOR2 U820 ( .A(n855), .B(n869), .Z(n868) );
  GTECH_NOR2 U821 ( .A(n762), .B(n869), .Z(n864) );
  GTECH_NOT U822 ( .A(n870), .Z(n1151) );
  GTECH_NOR2 U823 ( .A(n871), .B(n872), .Z(n870) );
  GTECH_NOR2 U824 ( .A(n747), .B(n873), .Z(n872) );
  GTECH_NOT U825 ( .A(n828), .Z(n873) );
  GTECH_NOR2 U826 ( .A(n738), .B(n874), .Z(n828) );
  GTECH_NOR2 U827 ( .A(n875), .B(n876), .Z(n874) );
  GTECH_NOT U828 ( .A(n877), .Z(n876) );
  GTECH_NOR2 U829 ( .A(n878), .B(n855), .Z(n877) );
  GTECH_NOR2 U830 ( .A(htrans[0]), .B(n879), .Z(n855) );
  GTECH_NOR2 U831 ( .A(n843), .B(n880), .Z(n878) );
  GTECH_NOT U832 ( .A(n881), .Z(n843) );
  GTECH_NOR2 U833 ( .A(n882), .B(n739), .Z(n875) );
  GTECH_NOT U834 ( .A(n883), .Z(n739) );
  GTECH_NOR2 U835 ( .A(n790), .B(n879), .Z(n883) );
  GTECH_NOR2 U836 ( .A(n884), .B(n861), .Z(n882) );
  GTECH_NOR2 U837 ( .A(n1137), .B(n1136), .Z(n861) );
  GTECH_NOR2 U838 ( .A(n880), .B(n869), .Z(n884) );
  GTECH_NOT U839 ( .A(n1137), .Z(n869) );
  GTECH_NOR2 U840 ( .A(hburst[1]), .B(hburst[2]), .Z(n738) );
  GTECH_NOT U841 ( .A(n762), .Z(n747) );
  GTECH_NOR2 U842 ( .A(n762), .B(n880), .Z(n871) );
  GTECH_NOT U843 ( .A(n1136), .Z(n880) );
  GTECH_NOR2 U844 ( .A(n713), .B(n879), .Z(n762) );
  GTECH_NOT U845 ( .A(htrans[1]), .Z(n879) );
  GTECH_NOT U846 ( .A(n885), .Z(n1152) );
  GTECH_NOR2 U847 ( .A(n886), .B(n887), .Z(n885) );
  GTECH_NOT U848 ( .A(n888), .Z(n887) );
  GTECH_NOR2 U849 ( .A(n889), .B(n890), .Z(n888) );
  GTECH_NOT U850 ( .A(n891), .Z(n890) );
  GTECH_NOR2 U851 ( .A(n892), .B(n893), .Z(n891) );
  GTECH_NOR2 U852 ( .A(n713), .B(n894), .Z(n893) );
  GTECH_NOT U853 ( .A(n895), .Z(n894) );
  GTECH_NOR2 U854 ( .A(n1130), .B(n584), .Z(n895) );
  GTECH_NOR2 U855 ( .A(n659), .B(n896), .Z(n892) );
  GTECH_NOR2 U856 ( .A(n659), .B(n897), .Z(n889) );
  GTECH_NOT U857 ( .A(n898), .Z(n886) );
  GTECH_NOR2 U858 ( .A(n899), .B(n900), .Z(n898) );
  GTECH_NOT U859 ( .A(n901), .Z(n900) );
  GTECH_NOR2 U860 ( .A(n902), .B(n903), .Z(n901) );
  GTECH_NOR2 U861 ( .A(n659), .B(n904), .Z(n903) );
  GTECH_NOR2 U862 ( .A(n905), .B(n906), .Z(n902) );
  GTECH_NOT U863 ( .A(n907), .Z(n906) );
  GTECH_NOR2 U864 ( .A(n584), .B(n908), .Z(n907) );
  GTECH_NOR2 U865 ( .A(n659), .B(n909), .Z(n899) );
  GTECH_NOT U866 ( .A(n910), .Z(n1153) );
  GTECH_NOR2 U867 ( .A(n911), .B(n912), .Z(n910) );
  GTECH_NOT U868 ( .A(n913), .Z(n912) );
  GTECH_NOR2 U869 ( .A(n914), .B(n915), .Z(n913) );
  GTECH_NOR2 U870 ( .A(n576), .B(n713), .Z(n915) );
  GTECH_NOR2 U871 ( .A(n584), .B(hready), .Z(n914) );
  GTECH_NOR2 U872 ( .A(n713), .B(n916), .Z(n911) );
  GTECH_NOT U873 ( .A(n917), .Z(n916) );
  GTECH_NOT U874 ( .A(n918), .Z(n1154) );
  GTECH_NOR2 U875 ( .A(n919), .B(n920), .Z(n918) );
  GTECH_NOT U876 ( .A(n921), .Z(n920) );
  GTECH_NOR2 U877 ( .A(n922), .B(n923), .Z(n921) );
  GTECH_NOT U878 ( .A(n924), .Z(n923) );
  GTECH_NOR2 U879 ( .A(n925), .B(n926), .Z(n924) );
  GTECH_NOR2 U880 ( .A(n713), .B(n927), .Z(n926) );
  GTECH_NOT U881 ( .A(n928), .Z(n927) );
  GTECH_NOR2 U882 ( .A(n1130), .B(n585), .Z(n928) );
  GTECH_NOR2 U883 ( .A(n639), .B(n896), .Z(n925) );
  GTECH_NOT U884 ( .A(n929), .Z(n896) );
  GTECH_NOR2 U885 ( .A(n1132), .B(n930), .Z(n929) );
  GTECH_NOR2 U886 ( .A(n639), .B(n897), .Z(n922) );
  GTECH_NOT U887 ( .A(n931), .Z(n897) );
  GTECH_NOR2 U888 ( .A(hready), .B(n1132), .Z(n931) );
  GTECH_NOT U889 ( .A(n932), .Z(n919) );
  GTECH_NOR2 U890 ( .A(n933), .B(n934), .Z(n932) );
  GTECH_NOT U891 ( .A(n935), .Z(n934) );
  GTECH_NOR2 U892 ( .A(n936), .B(n937), .Z(n935) );
  GTECH_NOR2 U893 ( .A(n639), .B(n904), .Z(n937) );
  GTECH_NOT U894 ( .A(n938), .Z(n904) );
  GTECH_NOR2 U895 ( .A(hready), .B(n939), .Z(n938) );
  GTECH_NOR2 U896 ( .A(n905), .B(n940), .Z(n936) );
  GTECH_NOT U897 ( .A(n941), .Z(n940) );
  GTECH_NOR2 U898 ( .A(n585), .B(n908), .Z(n941) );
  GTECH_NOR2 U899 ( .A(n639), .B(n909), .Z(n933) );
  GTECH_NOT U900 ( .A(n942), .Z(n909) );
  GTECH_NOR2 U901 ( .A(n939), .B(n930), .Z(n942) );
  GTECH_NOT U902 ( .A(n1130), .Z(n930) );
  GTECH_NOT U903 ( .A(n943), .Z(n1155) );
  GTECH_NOR2 U904 ( .A(n944), .B(n945), .Z(n943) );
  GTECH_NOT U905 ( .A(n946), .Z(n945) );
  GTECH_NOR2 U906 ( .A(n947), .B(n948), .Z(n946) );
  GTECH_NOR2 U907 ( .A(n713), .B(n949), .Z(n948) );
  GTECH_NOT U908 ( .A(n950), .Z(n949) );
  GTECH_NOR2 U909 ( .A(n585), .B(hready), .Z(n947) );
  GTECH_NOR2 U910 ( .A(n642), .B(n951), .Z(n944) );
  GTECH_NOT U911 ( .A(n952), .Z(n951) );
  GTECH_NOR2 U912 ( .A(n713), .B(n953), .Z(n952) );
  GTECH_NOT U913 ( .A(n954), .Z(n1156) );
  GTECH_NOR2 U914 ( .A(n955), .B(n956), .Z(n954) );
  GTECH_NOR2 U915 ( .A(n713), .B(n957), .Z(n956) );
  GTECH_NOT U916 ( .A(n958), .Z(n957) );
  GTECH_NOR2 U917 ( .A(n1132), .B(n908), .Z(n958) );
  GTECH_NOR2 U918 ( .A(n1130), .B(hready), .Z(n955) );
  GTECH_NOT U919 ( .A(n685), .Z(ltip) );
  GTECH_NOR2 U920 ( .A(n1161), .B(n696), .Z(n685) );
  GTECH_NOT U921 ( .A(n959), .Z(n696) );
  GTECH_NOR2 U922 ( .A(n1158), .B(n1160), .Z(n959) );
  GTECH_NOT U923 ( .A(n960), .Z(n1158) );
  GTECH_NOT U924 ( .A(n961), .Z(n1159) );
  GTECH_NOR2 U925 ( .A(n962), .B(n963), .Z(n961) );
  GTECH_NOR2 U926 ( .A(n908), .B(n964), .Z(n963) );
  GTECH_NOT U927 ( .A(n593), .Z(n964) );
  GTECH_NOR2 U928 ( .A(hready), .B(n592), .Z(n962) );
  GTECH_NOT U929 ( .A(n965), .Z(n1160) );
  GTECH_NOR2 U930 ( .A(n966), .B(n967), .Z(n965) );
  GTECH_NOT U931 ( .A(n968), .Z(n967) );
  GTECH_NOR2 U932 ( .A(n969), .B(n970), .Z(n968) );
  GTECH_NOR2 U933 ( .A(n971), .B(n972), .Z(n970) );
  GTECH_NOT U934 ( .A(n973), .Z(n972) );
  GTECH_NOR2 U935 ( .A(n974), .B(n975), .Z(n973) );
  GTECH_NOT U936 ( .A(n976), .Z(n971) );
  GTECH_NOR2 U937 ( .A(n977), .B(n978), .Z(n969) );
  GTECH_NOT U938 ( .A(n979), .Z(n978) );
  GTECH_NOR2 U939 ( .A(n980), .B(n981), .Z(n979) );
  GTECH_NOR2 U940 ( .A(n982), .B(n983), .Z(n966) );
  GTECH_NOT U941 ( .A(n984), .Z(n983) );
  GTECH_NOR2 U942 ( .A(n980), .B(n695), .Z(n984) );
  GTECH_NOT U943 ( .A(n985), .Z(n695) );
  GTECH_NOT U944 ( .A(n1131), .Z(n982) );
  GTECH_NOT U945 ( .A(n986), .Z(n1162) );
  GTECH_NOR2 U946 ( .A(n987), .B(n980), .Z(n986) );
  GTECH_NOR2 U947 ( .A(hready), .B(n988), .Z(n987) );
  GTECH_NOT U948 ( .A(n1125), .Z(n988) );
  GTECH_NOT U949 ( .A(n989), .Z(new_tfr) );
  GTECH_NOR2 U950 ( .A(n1125), .B(n790), .Z(n989) );
  GTECH_NOR2 U951 ( .A(n1161), .B(n960), .Z(n593) );
  GTECH_NOR2 U952 ( .A(n990), .B(n991), .Z(n960) );
  GTECH_NOT U953 ( .A(n992), .Z(n991) );
  GTECH_NOR2 U954 ( .A(n993), .B(n994), .Z(n992) );
  GTECH_NOR2 U955 ( .A(n995), .B(n996), .Z(n994) );
  GTECH_NOT U956 ( .A(n997), .Z(n996) );
  GTECH_NOR2 U957 ( .A(n998), .B(n999), .Z(n997) );
  GTECH_NOR2 U958 ( .A(n974), .B(n1000), .Z(n998) );
  GTECH_NOT U959 ( .A(n1001), .Z(n1000) );
  GTECH_NOR2 U960 ( .A(n1002), .B(n1003), .Z(n1001) );
  GTECH_NOT U961 ( .A(n1004), .Z(n1003) );
  GTECH_NOR2 U962 ( .A(n1005), .B(n1006), .Z(n1004) );
  GTECH_NOR2 U963 ( .A(n1007), .B(n1008), .Z(n1006) );
  GTECH_NOR2 U964 ( .A(r_hmaster_d[1]), .B(n819), .Z(n1008) );
  GTECH_NOT U965 ( .A(n584), .Z(n819) );
  GTECH_NOR2 U966 ( .A(n584), .B(n659), .Z(n1007) );
  GTECH_NOR2 U967 ( .A(n1009), .B(n1010), .Z(n1005) );
  GTECH_NOR2 U968 ( .A(r_hmaster_d[0]), .B(n813), .Z(n1010) );
  GTECH_NOT U969 ( .A(n585), .Z(n813) );
  GTECH_NOR2 U970 ( .A(n585), .B(n639), .Z(n1009) );
  GTECH_NOT U971 ( .A(n1011), .Z(n1002) );
  GTECH_NOR2 U972 ( .A(n592), .B(n1012), .Z(n1011) );
  GTECH_NOR2 U973 ( .A(n976), .B(n1013), .Z(n1012) );
  GTECH_NOR2 U974 ( .A(n1014), .B(n975), .Z(n993) );
  GTECH_NOR2 U975 ( .A(n1015), .B(n1016), .Z(n1014) );
  GTECH_NOR2 U976 ( .A(n1017), .B(n1018), .Z(n1015) );
  GTECH_NOR2 U977 ( .A(n976), .B(n980), .Z(n1017) );
  GTECH_NOT U978 ( .A(n1019), .Z(n990) );
  GTECH_NOR2 U979 ( .A(n1020), .B(n1021), .Z(n1019) );
  GTECH_NOR2 U980 ( .A(n1022), .B(n981), .Z(n1021) );
  GTECH_NOR2 U981 ( .A(n980), .B(n977), .Z(n1022) );
  GTECH_NOT U982 ( .A(n1023), .Z(n977) );
  GTECH_NOR2 U983 ( .A(n1024), .B(n1025), .Z(n1020) );
  GTECH_NOR2 U984 ( .A(n985), .B(n1131), .Z(n1025) );
  GTECH_NOR2 U985 ( .A(n1132), .B(n1133), .Z(n985) );
  GTECH_NOT U986 ( .A(n1026), .Z(n1161) );
  GTECH_NOR2 U987 ( .A(n1027), .B(n1028), .Z(n1026) );
  GTECH_NOT U988 ( .A(n1029), .Z(n1028) );
  GTECH_NOR2 U989 ( .A(n1030), .B(n1031), .Z(n1029) );
  GTECH_NOR2 U990 ( .A(n1032), .B(n995), .Z(n1031) );
  GTECH_NOT U991 ( .A(n1033), .Z(n995) );
  GTECH_NOR2 U992 ( .A(n1034), .B(n722), .Z(n1033) );
  GTECH_NOT U993 ( .A(n1035), .Z(n722) );
  GTECH_NOR2 U994 ( .A(n1131), .B(n1132), .Z(n1035) );
  GTECH_NOR2 U995 ( .A(n999), .B(n1036), .Z(n1032) );
  GTECH_NOR2 U996 ( .A(n1037), .B(n718), .Z(n1036) );
  GTECH_NOT U997 ( .A(n592), .Z(n718) );
  GTECH_NOT U998 ( .A(n1016), .Z(n1037) );
  GTECH_NOR2 U999 ( .A(n974), .B(n682), .Z(n1016) );
  GTECH_NOT U1000 ( .A(n1013), .Z(n682) );
  GTECH_NOR2 U1001 ( .A(n664), .B(n1038), .Z(n1013) );
  GTECH_NOT U1002 ( .A(hresp[0]), .Z(n1038) );
  GTECH_NOR2 U1003 ( .A(n980), .B(n1018), .Z(n999) );
  GTECH_NOT U1004 ( .A(n974), .Z(n1018) );
  GTECH_NOT U1005 ( .A(n1024), .Z(n980) );
  GTECH_NOR2 U1006 ( .A(n1039), .B(n1040), .Z(n1024) );
  GTECH_NOT U1007 ( .A(n1041), .Z(n1040) );
  GTECH_NOR2 U1008 ( .A(n1042), .B(n1043), .Z(n1041) );
  GTECH_NOR2 U1009 ( .A(n1044), .B(n1045), .Z(n1043) );
  GTECH_NOT U1010 ( .A(n1046), .Z(n1045) );
  GTECH_NOR2 U1011 ( .A(n1047), .B(n1048), .Z(n1046) );
  GTECH_NOT U1012 ( .A(n1049), .Z(n1048) );
  GTECH_NOR2 U1013 ( .A(n1050), .B(n1051), .Z(n1049) );
  GTECH_NOT U1014 ( .A(bus_hlock[2]), .Z(n1051) );
  GTECH_NOR2 U1015 ( .A(n1052), .B(n1053), .Z(n1042) );
  GTECH_NOT U1016 ( .A(n1054), .Z(n1053) );
  GTECH_NOR2 U1017 ( .A(n1047), .B(n1055), .Z(n1054) );
  GTECH_NOT U1018 ( .A(n1056), .Z(n1055) );
  GTECH_NOR2 U1019 ( .A(n1050), .B(n1057), .Z(n1056) );
  GTECH_NOT U1020 ( .A(bus_hlock[0]), .Z(n1057) );
  GTECH_NOT U1021 ( .A(n1058), .Z(n1047) );
  GTECH_NOR2 U1022 ( .A(n713), .B(n1059), .Z(n1058) );
  GTECH_NOR2 U1023 ( .A(n1060), .B(n1061), .Z(n1039) );
  GTECH_NOT U1024 ( .A(n1062), .Z(n1061) );
  GTECH_NOR2 U1025 ( .A(n1052), .B(n1063), .Z(n1062) );
  GTECH_NOT U1026 ( .A(bus_hlock[1]), .Z(n1063) );
  GTECH_NOT U1027 ( .A(n1064), .Z(n1060) );
  GTECH_NOR2 U1028 ( .A(n1050), .B(n1065), .Z(n1064) );
  GTECH_NOT U1029 ( .A(n1066), .Z(n1065) );
  GTECH_NOR2 U1030 ( .A(n1067), .B(n713), .Z(n1066) );
  GTECH_NOR2 U1031 ( .A(n975), .B(n1068), .Z(n1030) );
  GTECH_NOT U1032 ( .A(n1069), .Z(n1068) );
  GTECH_NOR2 U1033 ( .A(n974), .B(n976), .Z(n1069) );
  GTECH_NOR2 U1034 ( .A(hresp[0]), .B(n664), .Z(n976) );
  GTECH_NOT U1035 ( .A(hresp[1]), .Z(n664) );
  GTECH_NOR2 U1036 ( .A(n881), .B(n713), .Z(n974) );
  GTECH_NOR2 U1037 ( .A(htrans[1]), .B(n790), .Z(n881) );
  GTECH_NOT U1038 ( .A(htrans[0]), .Z(n790) );
  GTECH_NOT U1039 ( .A(n1070), .Z(n975) );
  GTECH_NOR2 U1040 ( .A(n908), .B(n905), .Z(n1070) );
  GTECH_NOT U1041 ( .A(n939), .Z(n908) );
  GTECH_NOR2 U1042 ( .A(n1131), .B(n1133), .Z(n939) );
  GTECH_NOR2 U1043 ( .A(n1023), .B(n981), .Z(n1027) );
  GTECH_NOT U1044 ( .A(n743), .Z(n981) );
  GTECH_NOR2 U1045 ( .A(n1131), .B(n1071), .Z(n743) );
  GTECH_NOR2 U1046 ( .A(n1072), .B(n1073), .Z(n1023) );
  GTECH_NOT U1047 ( .A(n1074), .Z(n1073) );
  GTECH_NOR2 U1048 ( .A(n713), .B(n1050), .Z(n1074) );
  GTECH_NOT U1049 ( .A(n1075), .Z(n1072) );
  GTECH_NOR2 U1050 ( .A(n1076), .B(n1077), .Z(n1075) );
  GTECH_NOR2 U1051 ( .A(n1078), .B(n1079), .Z(grant_changed) );
  GTECH_NOT U1052 ( .A(n1080), .Z(n1079) );
  GTECH_NOR2 U1053 ( .A(n713), .B(n1081), .Z(n1080) );
  GTECH_NOT U1054 ( .A(hready), .Z(n713) );
  GTECH_NOT U1055 ( .A(n1082), .Z(n1078) );
  GTECH_NOR2 U1056 ( .A(ahb_sc_arb), .B(n1083), .Z(n1082) );
  GTECH_NOR2 U1057 ( .A(hgrant_previous_0_), .B(n1084), .Z(n1083) );
  GTECH_NOT U1058 ( .A(n1085), .Z(n1084) );
  GTECH_NOR2 U1059 ( .A(n1086), .B(n1087), .Z(n1085) );
  GTECH_NOR2 U1060 ( .A(n1088), .B(n1089), .Z(n1087) );
  GTECH_NOR2 U1061 ( .A(n1127), .B(n1090), .Z(n1089) );
  GTECH_NOR2 U1062 ( .A(n582), .B(n1091), .Z(n1088) );
  GTECH_NOT U1063 ( .A(n1127), .Z(n1091) );
  GTECH_NOR2 U1064 ( .A(n1092), .B(n1093), .Z(n1086) );
  GTECH_NOR2 U1065 ( .A(n1129), .B(n1094), .Z(n1093) );
  GTECH_NOR2 U1066 ( .A(n576), .B(n1095), .Z(n1092) );
  GTECH_NOT U1067 ( .A(n1129), .Z(n1095) );
  GTECH_NOR2 U1068 ( .A(n1096), .B(n1097), .Z(est) );
  GTECH_NOT U1069 ( .A(n1098), .Z(n1097) );
  GTECH_NOR2 U1070 ( .A(n1050), .B(n1071), .Z(n1098) );
  GTECH_NOT U1071 ( .A(n1099), .Z(n1071) );
  GTECH_NOR2 U1072 ( .A(n905), .B(n1034), .Z(n1099) );
  GTECH_NOT U1073 ( .A(n1133), .Z(n1034) );
  GTECH_NOT U1074 ( .A(n1132), .Z(n905) );
  GTECH_NOT U1075 ( .A(n1100), .Z(n1050) );
  GTECH_NOR2 U1076 ( .A(n1101), .B(n1102), .Z(n1100) );
  GTECH_NOR2 U1077 ( .A(n1103), .B(n1104), .Z(n1102) );
  GTECH_NOT U1078 ( .A(def_mst[2]), .Z(n1103) );
  GTECH_NOR2 U1079 ( .A(n1105), .B(n1104), .Z(n1101) );
  GTECH_NOT U1080 ( .A(n1106), .Z(n1104) );
  GTECH_NOR2 U1081 ( .A(n1081), .B(n1107), .Z(n1106) );
  GTECH_NOT U1082 ( .A(n1108), .Z(n1107) );
  GTECH_NOR2 U1083 ( .A(n1094), .B(n1090), .Z(n1108) );
  GTECH_NOT U1084 ( .A(def_mst[3]), .Z(n1105) );
  GTECH_NOT U1085 ( .A(n1109), .Z(n1096) );
  GTECH_NOR2 U1086 ( .A(n1077), .B(n1110), .Z(n1109) );
  GTECH_NOT U1087 ( .A(n1111), .Z(n1110) );
  GTECH_NOR2 U1088 ( .A(n1131), .B(n1076), .Z(n1111) );
  GTECH_NOR2 U1089 ( .A(n1112), .B(n1113), .Z(n1076) );
  GTECH_NOR2 U1090 ( .A(r_hmaster_d[1]), .B(n1052), .Z(n1113) );
  GTECH_NOT U1091 ( .A(n1044), .Z(n1052) );
  GTECH_NOR2 U1092 ( .A(n1044), .B(n659), .Z(n1112) );
  GTECH_NOT U1093 ( .A(r_hmaster_d[1]), .Z(n659) );
  GTECH_NOR2 U1094 ( .A(n917), .B(n1094), .Z(n1044) );
  GTECH_NOR2 U1095 ( .A(n672), .B(n1114), .Z(n917) );
  GTECH_NOT U1096 ( .A(n1115), .Z(n1114) );
  GTECH_NOR2 U1097 ( .A(n1090), .B(n1081), .Z(n1115) );
  GTECH_NOT U1098 ( .A(n582), .Z(n1090) );
  GTECH_NOT U1099 ( .A(def_mst[1]), .Z(n672) );
  GTECH_NOR2 U1100 ( .A(n1116), .B(n1117), .Z(n1077) );
  GTECH_NOR2 U1101 ( .A(r_hmaster_d[0]), .B(n1059), .Z(n1117) );
  GTECH_NOT U1102 ( .A(n1067), .Z(n1059) );
  GTECH_NOR2 U1103 ( .A(n1067), .B(n639), .Z(n1116) );
  GTECH_NOT U1104 ( .A(r_hmaster_d[0]), .Z(n639) );
  GTECH_NOR2 U1105 ( .A(n1118), .B(n950), .Z(n1067) );
  GTECH_NOR2 U1106 ( .A(n582), .B(n1094), .Z(n950) );
  GTECH_NOR2 U1107 ( .A(n953), .B(n642), .Z(n1118) );
  GTECH_NOT U1108 ( .A(def_mst[0]), .Z(n642) );
  GTECH_NOT U1109 ( .A(n1119), .Z(n953) );
  GTECH_NOR2 U1110 ( .A(n1094), .B(n1081), .Z(n1119) );
  GTECH_NOT U1111 ( .A(n583), .Z(n1081) );
  GTECH_NOT U1112 ( .A(n576), .Z(n1094) );
endmodule


module DW_ahb_bcm01_7_3_2_DW_minmax_0 ( a, tc, min_max, value, index );
  input [20:0] a;
  output [6:0] value;
  output [1:0] index;
  input tc, min_max;
  wire   n10, n11, n12, n13, n14, n15, n16, n17, n18, n19, n20, n21, n22, n23,
         n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35, n36, n37,
         n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49, n50, n51,
         n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65,
         n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79,
         n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91, n92, n93,
         n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n104, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178;

  GTECH_NOT U3 ( .A(n65), .Z(value[6]) );
  GTECH_NOT U4 ( .A(n69), .Z(value[5]) );
  GTECH_NOT U5 ( .A(n73), .Z(value[4]) );
  GTECH_NOT U6 ( .A(n77), .Z(value[3]) );
  GTECH_NOT U7 ( .A(n81), .Z(value[2]) );
  GTECH_NOT U8 ( .A(n85), .Z(value[1]) );
  GTECH_NOT U9 ( .A(n89), .Z(value[0]) );
  GTECH_NOT U10 ( .A(n91), .Z(n10) );
  GTECH_NOT U11 ( .A(index[1]), .Z(n11) );
  GTECH_NOT U12 ( .A(index[0]), .Z(n12) );
  GTECH_NOT U13 ( .A(n98), .Z(n13) );
  GTECH_NOT U14 ( .A(n102), .Z(n14) );
  GTECH_NOT U15 ( .A(a[20]), .Z(n15) );
  GTECH_NOT U16 ( .A(a[19]), .Z(n16) );
  GTECH_NOT U17 ( .A(a[18]), .Z(n17) );
  GTECH_NOT U18 ( .A(n107), .Z(n18) );
  GTECH_NOT U19 ( .A(n111), .Z(n19) );
  GTECH_NOT U20 ( .A(n114), .Z(n20) );
  GTECH_NOT U21 ( .A(n125), .Z(n21) );
  GTECH_NOT U22 ( .A(n117), .Z(n22) );
  GTECH_NOT U23 ( .A(a[17]), .Z(n23) );
  GTECH_NOT U24 ( .A(n119), .Z(n24) );
  GTECH_NOT U25 ( .A(a[16]), .Z(n25) );
  GTECH_NOT U26 ( .A(a[15]), .Z(n26) );
  GTECH_NOT U27 ( .A(a[14]), .Z(n27) );
  GTECH_NOT U28 ( .A(n124), .Z(n28) );
  GTECH_NOT U29 ( .A(n101), .Z(n29) );
  GTECH_NOT U30 ( .A(n68), .Z(n30) );
  GTECH_NOT U31 ( .A(n72), .Z(n31) );
  GTECH_NOT U32 ( .A(n76), .Z(n32) );
  GTECH_NOT U33 ( .A(n80), .Z(n33) );
  GTECH_NOT U34 ( .A(n88), .Z(n34) );
  GTECH_NOT U35 ( .A(n128), .Z(n35) );
  GTECH_NOT U36 ( .A(n84), .Z(n36) );
  GTECH_NOT U37 ( .A(n95), .Z(n37) );
  GTECH_NOT U38 ( .A(n94), .Z(n38) );
  GTECH_NOT U39 ( .A(n145), .Z(n39) );
  GTECH_NOT U40 ( .A(n149), .Z(n40) );
  GTECH_NOT U41 ( .A(a[13]), .Z(n41) );
  GTECH_NOT U42 ( .A(a[12]), .Z(n42) );
  GTECH_NOT U43 ( .A(n154), .Z(n43) );
  GTECH_NOT U44 ( .A(a[11]), .Z(n44) );
  GTECH_NOT U45 ( .A(n158), .Z(n45) );
  GTECH_NOT U46 ( .A(n161), .Z(n46) );
  GTECH_NOT U47 ( .A(n170), .Z(n47) );
  GTECH_NOT U48 ( .A(n164), .Z(n48) );
  GTECH_NOT U49 ( .A(a[10]), .Z(n49) );
  GTECH_NOT U50 ( .A(n166), .Z(n50) );
  GTECH_NOT U51 ( .A(a[9]), .Z(n51) );
  GTECH_NOT U52 ( .A(a[8]), .Z(n52) );
  GTECH_NOT U53 ( .A(a[7]), .Z(n53) );
  GTECH_NOT U54 ( .A(n169), .Z(n54) );
  GTECH_NOT U55 ( .A(n148), .Z(n55) );
  GTECH_NOT U56 ( .A(a[6]), .Z(n56) );
  GTECH_NOT U57 ( .A(a[5]), .Z(n57) );
  GTECH_NOT U58 ( .A(a[4]), .Z(n58) );
  GTECH_NOT U59 ( .A(a[3]), .Z(n59) );
  GTECH_NOT U60 ( .A(a[2]), .Z(n60) );
  GTECH_NOT U61 ( .A(a[1]), .Z(n61) );
  GTECH_NOT U62 ( .A(a[0]), .Z(n62) );
  GTECH_NOT U63 ( .A(tc), .Z(n63) );
  GTECH_NOT U64 ( .A(min_max), .Z(n64) );
  GTECH_NOR2 U65 ( .A(n66), .B(n67), .Z(n65) );
  GTECH_NOR2 U66 ( .A(n68), .B(index[1]), .Z(n67) );
  GTECH_NOR2 U67 ( .A(n11), .B(n15), .Z(n66) );
  GTECH_NOR2 U68 ( .A(n70), .B(n71), .Z(n69) );
  GTECH_NOR2 U69 ( .A(n72), .B(index[1]), .Z(n71) );
  GTECH_NOR2 U70 ( .A(n11), .B(n16), .Z(n70) );
  GTECH_NOR2 U71 ( .A(n74), .B(n75), .Z(n73) );
  GTECH_NOR2 U72 ( .A(n76), .B(index[1]), .Z(n75) );
  GTECH_NOR2 U73 ( .A(n11), .B(n17), .Z(n74) );
  GTECH_NOR2 U74 ( .A(n78), .B(n79), .Z(n77) );
  GTECH_NOR2 U75 ( .A(n80), .B(index[1]), .Z(n79) );
  GTECH_NOR2 U76 ( .A(n23), .B(n11), .Z(n78) );
  GTECH_NOR2 U77 ( .A(n82), .B(n83), .Z(n81) );
  GTECH_NOR2 U78 ( .A(n84), .B(index[1]), .Z(n83) );
  GTECH_NOR2 U79 ( .A(n25), .B(n11), .Z(n82) );
  GTECH_NOR2 U80 ( .A(n86), .B(n87), .Z(n85) );
  GTECH_NOR2 U81 ( .A(n88), .B(index[1]), .Z(n87) );
  GTECH_NOR2 U82 ( .A(n26), .B(n11), .Z(n86) );
  GTECH_NOR2 U83 ( .A(n90), .B(n10), .Z(n89) );
  GTECH_NOR2 U84 ( .A(n92), .B(n93), .Z(n91) );
  GTECH_NOR2 U85 ( .A(index[1]), .B(n38), .Z(n93) );
  GTECH_NOR2 U86 ( .A(n95), .B(n62), .Z(n94) );
  GTECH_NOR2 U87 ( .A(n11), .B(n27), .Z(n92) );
  GTECH_NOR2 U88 ( .A(n12), .B(n53), .Z(n90) );
  GTECH_NOR2 U89 ( .A(index[1]), .B(n37), .Z(index[0]) );
  GTECH_NOR2 U90 ( .A(n96), .B(n97), .Z(index[1]) );
  GTECH_NOR2 U91 ( .A(min_max), .B(n13), .Z(n97) );
  GTECH_NOR2 U92 ( .A(n98), .B(n64), .Z(n96) );
  GTECH_NOR2 U93 ( .A(n99), .B(n100), .Z(n98) );
  GTECH_NOR2 U94 ( .A(n101), .B(n14), .Z(n100) );
  GTECH_NOR2 U95 ( .A(n103), .B(n104), .Z(n99) );
  GTECH_NOR2 U96 ( .A(n105), .B(n106), .Z(n104) );
  GTECH_NOR2 U97 ( .A(n107), .B(n72), .Z(n106) );
  GTECH_NOR2 U98 ( .A(a[19]), .B(n108), .Z(n105) );
  GTECH_NOR2 U99 ( .A(n31), .B(n18), .Z(n108) );
  GTECH_NOR2 U100 ( .A(n109), .B(n110), .Z(n107) );
  GTECH_NOR2 U101 ( .A(n111), .B(n76), .Z(n110) );
  GTECH_NOR2 U102 ( .A(a[18]), .B(n112), .Z(n109) );
  GTECH_NOR2 U103 ( .A(n32), .B(n19), .Z(n112) );
  GTECH_NOR2 U104 ( .A(n113), .B(n20), .Z(n111) );
  GTECH_NOR2 U105 ( .A(n115), .B(n116), .Z(n114) );
  GTECH_NOR2 U106 ( .A(a[17]), .B(n80), .Z(n116) );
  GTECH_NOR2 U107 ( .A(n84), .B(n22), .Z(n115) );
  GTECH_NOR2 U108 ( .A(a[16]), .B(n118), .Z(n117) );
  GTECH_NOR2 U109 ( .A(n21), .B(n24), .Z(n113) );
  GTECH_NOR2 U110 ( .A(n120), .B(n121), .Z(n119) );
  GTECH_NOR2 U111 ( .A(n36), .B(n25), .Z(n121) );
  GTECH_NOR2 U112 ( .A(n122), .B(n123), .Z(n84) );
  GTECH_NOR2 U113 ( .A(n60), .B(n95), .Z(n123) );
  GTECH_NOR2 U114 ( .A(n51), .B(n37), .Z(n122) );
  GTECH_NOR2 U115 ( .A(n124), .B(n34), .Z(n120) );
  GTECH_NOR2 U116 ( .A(n118), .B(n126), .Z(n125) );
  GTECH_NOR2 U117 ( .A(n127), .B(n26), .Z(n126) );
  GTECH_NOR2 U118 ( .A(n88), .B(n28), .Z(n127) );
  GTECH_NOR2 U119 ( .A(a[14]), .B(n35), .Z(n124) );
  GTECH_NOR2 U120 ( .A(n129), .B(n130), .Z(n128) );
  GTECH_NOR2 U121 ( .A(a[7]), .B(n37), .Z(n130) );
  GTECH_NOR2 U122 ( .A(a[0]), .B(n95), .Z(n129) );
  GTECH_NOR2 U123 ( .A(n131), .B(n132), .Z(n88) );
  GTECH_NOR2 U124 ( .A(n61), .B(n95), .Z(n132) );
  GTECH_NOR2 U125 ( .A(n52), .B(n37), .Z(n131) );
  GTECH_NOR2 U126 ( .A(n33), .B(n23), .Z(n118) );
  GTECH_NOR2 U127 ( .A(n133), .B(n134), .Z(n80) );
  GTECH_NOR2 U128 ( .A(n59), .B(n95), .Z(n134) );
  GTECH_NOR2 U129 ( .A(n49), .B(n37), .Z(n133) );
  GTECH_NOR2 U130 ( .A(n135), .B(n136), .Z(n76) );
  GTECH_NOR2 U131 ( .A(n58), .B(n95), .Z(n136) );
  GTECH_NOR2 U132 ( .A(n44), .B(n37), .Z(n135) );
  GTECH_NOR2 U133 ( .A(n137), .B(n138), .Z(n72) );
  GTECH_NOR2 U134 ( .A(n57), .B(n95), .Z(n138) );
  GTECH_NOR2 U135 ( .A(n42), .B(n37), .Z(n137) );
  GTECH_NOR2 U136 ( .A(n102), .B(n29), .Z(n103) );
  GTECH_NOR2 U137 ( .A(n139), .B(n140), .Z(n101) );
  GTECH_NOR2 U138 ( .A(tc), .B(n68), .Z(n140) );
  GTECH_NOR2 U139 ( .A(n30), .B(n63), .Z(n139) );
  GTECH_NOR2 U140 ( .A(n141), .B(n142), .Z(n68) );
  GTECH_NOR2 U141 ( .A(n56), .B(n95), .Z(n142) );
  GTECH_NOR2 U142 ( .A(n37), .B(n41), .Z(n141) );
  GTECH_NOR2 U143 ( .A(n143), .B(n144), .Z(n95) );
  GTECH_NOR2 U144 ( .A(min_max), .B(n39), .Z(n144) );
  GTECH_NOR2 U145 ( .A(n145), .B(n64), .Z(n143) );
  GTECH_NOR2 U146 ( .A(n146), .B(n147), .Z(n145) );
  GTECH_NOR2 U147 ( .A(n148), .B(n40), .Z(n147) );
  GTECH_NOR2 U148 ( .A(n150), .B(n151), .Z(n146) );
  GTECH_NOR2 U149 ( .A(n152), .B(n153), .Z(n151) );
  GTECH_NOR2 U150 ( .A(a[12]), .B(n154), .Z(n153) );
  GTECH_NOR2 U151 ( .A(n155), .B(n57), .Z(n152) );
  GTECH_NOR2 U152 ( .A(n43), .B(n42), .Z(n155) );
  GTECH_NOR2 U153 ( .A(n156), .B(n157), .Z(n154) );
  GTECH_NOR2 U154 ( .A(a[11]), .B(n158), .Z(n157) );
  GTECH_NOR2 U155 ( .A(n159), .B(n58), .Z(n156) );
  GTECH_NOR2 U156 ( .A(n45), .B(n44), .Z(n159) );
  GTECH_NOR2 U157 ( .A(n160), .B(n46), .Z(n158) );
  GTECH_NOR2 U158 ( .A(n162), .B(n163), .Z(n161) );
  GTECH_NOR2 U159 ( .A(a[10]), .B(n59), .Z(n163) );
  GTECH_NOR2 U160 ( .A(n60), .B(n48), .Z(n162) );
  GTECH_NOR2 U161 ( .A(a[9]), .B(n165), .Z(n164) );
  GTECH_NOR2 U162 ( .A(n47), .B(n50), .Z(n160) );
  GTECH_NOR2 U163 ( .A(n167), .B(n168), .Z(n166) );
  GTECH_NOR2 U164 ( .A(a[2]), .B(n51), .Z(n168) );
  GTECH_NOR2 U165 ( .A(a[1]), .B(n169), .Z(n167) );
  GTECH_NOR2 U166 ( .A(n165), .B(n171), .Z(n170) );
  GTECH_NOR2 U167 ( .A(n172), .B(n52), .Z(n171) );
  GTECH_NOR2 U168 ( .A(n54), .B(n61), .Z(n172) );
  GTECH_NOR2 U169 ( .A(a[7]), .B(n62), .Z(n169) );
  GTECH_NOR2 U170 ( .A(a[3]), .B(n49), .Z(n165) );
  GTECH_NOR2 U171 ( .A(n149), .B(n55), .Z(n150) );
  GTECH_NOR2 U172 ( .A(n173), .B(n174), .Z(n148) );
  GTECH_NOR2 U173 ( .A(tc), .B(n56), .Z(n174) );
  GTECH_NOR2 U174 ( .A(a[6]), .B(n63), .Z(n173) );
  GTECH_NOR2 U175 ( .A(n175), .B(n176), .Z(n149) );
  GTECH_NOR2 U176 ( .A(tc), .B(n41), .Z(n176) );
  GTECH_NOR2 U177 ( .A(a[13]), .B(n63), .Z(n175) );
  GTECH_NOR2 U178 ( .A(n177), .B(n178), .Z(n102) );
  GTECH_NOR2 U179 ( .A(tc), .B(n15), .Z(n178) );
  GTECH_NOR2 U180 ( .A(a[20]), .B(n63), .Z(n177) );
endmodule


module DW_ahb_bcm01_7_3_2 ( a, tc, min_max, value, index );
  input [20:0] a;
  output [6:0] value;
  output [1:0] index;
  input tc, min_max;


  DW_ahb_bcm01_7_3_2_DW_minmax_0 U1 ( .a(a), .tc(tc), .min_max(min_max), 
        .value(value), .index(index) );
endmodule


module DW_ahb_bcm53_3_4_1_0_0_2 ( clk, rst_n, init_n, enable, request, prior, 
        lock, mask, parked, granted, locked, grant, grant_index );
  input [2:0] request;
  input [11:0] prior;
  input [2:0] lock;
  input [2:0] mask;
  output [2:0] grant;
  output [1:0] grant_index;
  input clk, rst_n, init_n, enable;
  output parked, granted, locked;
  wire   priority_vec_8, priority_vec_7, priority_vec_1, priority_vec_0, n266,
         n268, n270, n271, n272, n274, n275, n276, n278, n279, n281, n283,
         n285, n287, n289, n290, n291, n299, n300, n301, n302, n303, n304,
         n305, n306, n307, n308, n309, n310, n311, n312, n313, n315, n316,
         n317, n318, n319, n320, n321, n322, n323, n324, n325, n326, n327,
         n328, n329, n330, n331, n332, n333, n334, n335, n336, n337, n338,
         n339, n340, n341, n342, n343, n344, n345, n346, n347, n348, n349,
         n350, n351, n352, n353, n354, n355, n356, n357, n358, n359, n360,
         n361, n362, n363, n364, n365, n366, n367, n368, n369, n370, n371,
         n372, n373, n374, n375, n376, n377, n378, n379, n380, n381, n382,
         n383, n384, n385, n386, n387, n388, n389, n390, n391, n392, n393,
         n394, n395, n396, n397, n398, n399, n400, n401, n402, n403, n404,
         n405, n406, n407, n408, n409, n410, n411, n412, n413, n414, n415,
         n416, n417, n418, n419, n420, n421, n422, n423, n424, n425, n426,
         n427, n428, n429, n430, n431, n432, n433, n434, n435, n436, n437,
         n438, n439, n440, n441, n442, n443, n444, n445, n446, n447, n448,
         n449, n450, n451, n452, n453, n454, n455, n456, n457, n458, n459,
         n460, n461, n462, n463, n464, n465, n466, n467, n468, n469, n470,
         n471, n472, n473, n474, n475, n476, n477, n478, n479, n480, n481,
         n482, n483, n484, n485, n486, n487, n488, n489, n490, n491, n492,
         n493, n494, n495, n496, n497, n498, n499, n500, n501, n502, n503,
         n504, n505, n506, n507, n508, n509, n510, n511, n512, n513, n514,
         n515, n516, n517, n518, n519, n520, n521, n522, n523, n524, n525,
         n526, n527, n528, n529, n530, n531, n532, n533, n534, n535, n536,
         n537, n538, n539, n540, n541, n542, n543, n544, n545, n546, n547,
         n548, n549, n550, n551, n552, n553, n554, n555, n556, n557, n558,
         n559, n560, n561, n562, n563, n564, n565, n566, n567, n568, n569,
         n570, n571, n572, n573, n574, n575, n576, n577, n578, n579, n580,
         n581, n582, n583, n584, n585, n586, n587, n588, n589;
  wire   [15:14] priority_vec;
  wire   [1:0] current_index;

  DW_ahb_bcm01_7_3_2 U_minmax ( .a({n303, n299, n300, n301, n302, n279, n281, 
        n308, n305, n306, n307, n304, n283, n285, n313, n309, n310, n311, n312, 
        n287, n289}), .tc(1'b0), .min_max(1'b0), .index(current_index) );
  GTECH_FD2 grant_int_reg_0_ ( .D(n278), .CP(clk), .CD(rst_n), .QN(n588) );
  GTECH_FD2 grant_int_reg_1_ ( .D(n274), .CP(clk), .CD(rst_n), .QN(n589) );
  GTECH_FD2 grant_int_reg_2_ ( .D(n270), .CP(clk), .CD(rst_n), .QN(n587) );
  GTECH_FD2 current_state_reg_0_ ( .D(n291), .CP(clk), .CD(rst_n), .Q(n586) );
  GTECH_FD2 current_state_reg_1_ ( .D(n290), .CP(clk), .CD(rst_n), .Q(n585) );
  GTECH_FD4 int_priority_reg_0_ ( .D(n276), .CP(clk), .SD(rst_n), .Q(
        priority_vec_0) );
  GTECH_FD4 int_priority_reg_1_ ( .D(n275), .CP(clk), .SD(rst_n), .Q(
        priority_vec_1) );
  GTECH_FD4 int_priority_reg_2_ ( .D(n272), .CP(clk), .SD(rst_n), .Q(
        priority_vec_7) );
  GTECH_FD4 int_priority_reg_3_ ( .D(n271), .CP(clk), .SD(rst_n), .Q(
        priority_vec_8) );
  GTECH_FD4 int_priority_reg_4_ ( .D(n268), .CP(clk), .SD(rst_n), .Q(
        priority_vec[14]) );
  GTECH_FD4 int_priority_reg_5_ ( .D(n266), .CP(clk), .SD(rst_n), .Q(
        priority_vec[15]) );
  GTECH_NOT U304 ( .A(n315), .Z(n312) );
  GTECH_NOR2 U305 ( .A(prior[0]), .B(n313), .Z(n315) );
  GTECH_NOT U306 ( .A(n316), .Z(n311) );
  GTECH_NOR2 U307 ( .A(prior[1]), .B(n313), .Z(n316) );
  GTECH_NOT U308 ( .A(n317), .Z(n310) );
  GTECH_NOR2 U309 ( .A(prior[2]), .B(n313), .Z(n317) );
  GTECH_NOT U310 ( .A(n318), .Z(n309) );
  GTECH_NOR2 U311 ( .A(prior[3]), .B(n313), .Z(n318) );
  GTECH_NOT U312 ( .A(n319), .Z(n307) );
  GTECH_NOR2 U313 ( .A(prior[5]), .B(n308), .Z(n319) );
  GTECH_NOT U314 ( .A(n320), .Z(n306) );
  GTECH_NOR2 U315 ( .A(prior[6]), .B(n308), .Z(n320) );
  GTECH_NOT U316 ( .A(n321), .Z(n305) );
  GTECH_NOR2 U317 ( .A(prior[7]), .B(n308), .Z(n321) );
  GTECH_NOT U318 ( .A(n322), .Z(n304) );
  GTECH_NOR2 U319 ( .A(prior[4]), .B(n308), .Z(n322) );
  GTECH_NOT U320 ( .A(n323), .Z(n302) );
  GTECH_NOR2 U321 ( .A(prior[8]), .B(n303), .Z(n323) );
  GTECH_NOT U322 ( .A(n324), .Z(n301) );
  GTECH_NOR2 U323 ( .A(prior[9]), .B(n303), .Z(n324) );
  GTECH_NOT U324 ( .A(n325), .Z(n300) );
  GTECH_NOR2 U325 ( .A(prior[10]), .B(n303), .Z(n325) );
  GTECH_NOT U326 ( .A(n326), .Z(n299) );
  GTECH_NOR2 U327 ( .A(prior[11]), .B(n303), .Z(n326) );
  GTECH_NOT U328 ( .A(n327), .Z(n291) );
  GTECH_NOR2 U329 ( .A(n328), .B(n329), .Z(n327) );
  GTECH_NOR2 U330 ( .A(n330), .B(n331), .Z(n329) );
  GTECH_NOR2 U331 ( .A(n332), .B(n333), .Z(n328) );
  GTECH_NOR2 U332 ( .A(n334), .B(n335), .Z(n332) );
  GTECH_NOT U333 ( .A(n336), .Z(n335) );
  GTECH_NOR2 U334 ( .A(parked), .B(n337), .Z(n336) );
  GTECH_NOR2 U335 ( .A(n338), .B(n330), .Z(n337) );
  GTECH_NOR2 U336 ( .A(n338), .B(n339), .Z(n334) );
  GTECH_NOT U337 ( .A(n340), .Z(n290) );
  GTECH_NOR2 U338 ( .A(n341), .B(n342), .Z(n340) );
  GTECH_NOR2 U339 ( .A(n339), .B(n331), .Z(n342) );
  GTECH_NOR2 U340 ( .A(n343), .B(n333), .Z(n341) );
  GTECH_NOR2 U341 ( .A(n344), .B(n345), .Z(n343) );
  GTECH_NOT U342 ( .A(n346), .Z(n345) );
  GTECH_NOR2 U343 ( .A(n347), .B(n348), .Z(n346) );
  GTECH_NOR2 U344 ( .A(parked), .B(n330), .Z(n348) );
  GTECH_NOR2 U345 ( .A(parked), .B(n339), .Z(n344) );
  GTECH_NOT U346 ( .A(n349), .Z(n278) );
  GTECH_NOR2 U347 ( .A(n350), .B(n351), .Z(n349) );
  GTECH_NOR2 U348 ( .A(n352), .B(n333), .Z(n351) );
  GTECH_NOR2 U349 ( .A(n588), .B(n331), .Z(n350) );
  GTECH_NOT U350 ( .A(n353), .Z(n276) );
  GTECH_NOR2 U351 ( .A(n354), .B(n355), .Z(n353) );
  GTECH_NOT U352 ( .A(n356), .Z(n355) );
  GTECH_NOR2 U353 ( .A(n357), .B(n358), .Z(n356) );
  GTECH_NOR2 U354 ( .A(n331), .B(n359), .Z(n358) );
  GTECH_NOR2 U355 ( .A(n360), .B(n333), .Z(n357) );
  GTECH_NOR2 U356 ( .A(n361), .B(n362), .Z(n360) );
  GTECH_NOT U357 ( .A(n363), .Z(n362) );
  GTECH_NOR2 U358 ( .A(n364), .B(n365), .Z(n363) );
  GTECH_NOR2 U359 ( .A(n366), .B(n367), .Z(n365) );
  GTECH_NOR2 U360 ( .A(n368), .B(n369), .Z(n364) );
  GTECH_NOR2 U361 ( .A(n370), .B(n371), .Z(n368) );
  GTECH_NOT U362 ( .A(n372), .Z(n371) );
  GTECH_NOR2 U363 ( .A(n313), .B(n373), .Z(n372) );
  GTECH_NOR2 U364 ( .A(priority_vec_0), .B(locked), .Z(n373) );
  GTECH_NOT U365 ( .A(n374), .Z(n370) );
  GTECH_NOR2 U366 ( .A(n375), .B(n376), .Z(n374) );
  GTECH_NOR2 U367 ( .A(priority_vec_0), .B(grant[0]), .Z(n376) );
  GTECH_NOR2 U368 ( .A(n352), .B(n359), .Z(n375) );
  GTECH_NOR2 U369 ( .A(n339), .B(n377), .Z(n361) );
  GTECH_NOT U370 ( .A(n378), .Z(n377) );
  GTECH_NOR2 U371 ( .A(n379), .B(n380), .Z(n378) );
  GTECH_NOR2 U372 ( .A(n289), .B(n338), .Z(n380) );
  GTECH_NOT U373 ( .A(n381), .Z(n289) );
  GTECH_NOR2 U374 ( .A(priority_vec_0), .B(n313), .Z(n381) );
  GTECH_NOR2 U375 ( .A(locked), .B(n382), .Z(n379) );
  GTECH_NOT U376 ( .A(n366), .Z(n382) );
  GTECH_NOR2 U377 ( .A(n359), .B(n383), .Z(n366) );
  GTECH_NOT U378 ( .A(n384), .Z(n275) );
  GTECH_NOR2 U379 ( .A(n354), .B(n385), .Z(n384) );
  GTECH_NOT U380 ( .A(n386), .Z(n385) );
  GTECH_NOR2 U381 ( .A(n387), .B(n388), .Z(n386) );
  GTECH_NOR2 U382 ( .A(n331), .B(n389), .Z(n388) );
  GTECH_NOR2 U383 ( .A(n390), .B(n333), .Z(n387) );
  GTECH_NOR2 U384 ( .A(n391), .B(n392), .Z(n390) );
  GTECH_NOT U385 ( .A(n393), .Z(n392) );
  GTECH_NOR2 U386 ( .A(n394), .B(n395), .Z(n393) );
  GTECH_NOR2 U387 ( .A(n396), .B(n367), .Z(n395) );
  GTECH_NOR2 U388 ( .A(n397), .B(n369), .Z(n394) );
  GTECH_NOR2 U389 ( .A(n398), .B(n399), .Z(n397) );
  GTECH_NOT U390 ( .A(n400), .Z(n399) );
  GTECH_NOR2 U391 ( .A(n313), .B(n401), .Z(n400) );
  GTECH_NOR2 U392 ( .A(n352), .B(n389), .Z(n401) );
  GTECH_NOT U393 ( .A(n402), .Z(n398) );
  GTECH_NOR2 U394 ( .A(n403), .B(n404), .Z(n402) );
  GTECH_NOR2 U395 ( .A(locked), .B(n352), .Z(n404) );
  GTECH_NOR2 U396 ( .A(grant[0]), .B(n405), .Z(n403) );
  GTECH_NOT U397 ( .A(n406), .Z(n405) );
  GTECH_NOR2 U398 ( .A(n339), .B(n407), .Z(n391) );
  GTECH_NOT U399 ( .A(n408), .Z(n407) );
  GTECH_NOR2 U400 ( .A(n409), .B(n410), .Z(n408) );
  GTECH_NOR2 U401 ( .A(n287), .B(n338), .Z(n410) );
  GTECH_NOT U402 ( .A(n411), .Z(n287) );
  GTECH_NOR2 U403 ( .A(priority_vec_1), .B(n313), .Z(n411) );
  GTECH_NOR2 U404 ( .A(locked), .B(n412), .Z(n409) );
  GTECH_NOT U405 ( .A(n396), .Z(n412) );
  GTECH_NOR2 U406 ( .A(n406), .B(n383), .Z(n396) );
  GTECH_NOT U407 ( .A(n413), .Z(n383) );
  GTECH_NOR2 U408 ( .A(n313), .B(grant[0]), .Z(n413) );
  GTECH_NOT U409 ( .A(n414), .Z(n313) );
  GTECH_NOR2 U410 ( .A(n415), .B(n416), .Z(n406) );
  GTECH_NOR2 U411 ( .A(priority_vec_1), .B(n359), .Z(n416) );
  GTECH_NOT U412 ( .A(priority_vec_0), .Z(n359) );
  GTECH_NOR2 U413 ( .A(priority_vec_0), .B(n389), .Z(n415) );
  GTECH_NOT U414 ( .A(priority_vec_1), .Z(n389) );
  GTECH_NOT U415 ( .A(n417), .Z(n274) );
  GTECH_NOR2 U416 ( .A(n418), .B(n419), .Z(n417) );
  GTECH_NOR2 U417 ( .A(n420), .B(n333), .Z(n419) );
  GTECH_NOR2 U418 ( .A(n589), .B(n331), .Z(n418) );
  GTECH_NOT U419 ( .A(n421), .Z(n272) );
  GTECH_NOR2 U420 ( .A(n354), .B(n422), .Z(n421) );
  GTECH_NOT U421 ( .A(n423), .Z(n422) );
  GTECH_NOR2 U422 ( .A(n424), .B(n425), .Z(n423) );
  GTECH_NOR2 U423 ( .A(n331), .B(n426), .Z(n425) );
  GTECH_NOR2 U424 ( .A(n427), .B(n333), .Z(n424) );
  GTECH_NOR2 U425 ( .A(n428), .B(n429), .Z(n427) );
  GTECH_NOT U426 ( .A(n430), .Z(n429) );
  GTECH_NOR2 U427 ( .A(n431), .B(n432), .Z(n430) );
  GTECH_NOR2 U428 ( .A(n433), .B(n367), .Z(n432) );
  GTECH_NOR2 U429 ( .A(n434), .B(n369), .Z(n431) );
  GTECH_NOR2 U430 ( .A(n435), .B(n436), .Z(n434) );
  GTECH_NOT U431 ( .A(n437), .Z(n436) );
  GTECH_NOR2 U432 ( .A(n308), .B(n438), .Z(n437) );
  GTECH_NOR2 U433 ( .A(priority_vec_7), .B(locked), .Z(n438) );
  GTECH_NOT U434 ( .A(n439), .Z(n435) );
  GTECH_NOR2 U435 ( .A(n440), .B(n441), .Z(n439) );
  GTECH_NOR2 U436 ( .A(priority_vec_7), .B(grant[1]), .Z(n441) );
  GTECH_NOR2 U437 ( .A(n420), .B(n426), .Z(n440) );
  GTECH_NOR2 U438 ( .A(n339), .B(n442), .Z(n428) );
  GTECH_NOT U439 ( .A(n443), .Z(n442) );
  GTECH_NOR2 U440 ( .A(n444), .B(n445), .Z(n443) );
  GTECH_NOR2 U441 ( .A(n285), .B(n338), .Z(n445) );
  GTECH_NOT U442 ( .A(n446), .Z(n285) );
  GTECH_NOR2 U443 ( .A(priority_vec_7), .B(n308), .Z(n446) );
  GTECH_NOR2 U444 ( .A(locked), .B(n447), .Z(n444) );
  GTECH_NOT U445 ( .A(n433), .Z(n447) );
  GTECH_NOR2 U446 ( .A(n426), .B(n448), .Z(n433) );
  GTECH_NOT U447 ( .A(n449), .Z(n271) );
  GTECH_NOR2 U448 ( .A(n354), .B(n450), .Z(n449) );
  GTECH_NOT U449 ( .A(n451), .Z(n450) );
  GTECH_NOR2 U450 ( .A(n452), .B(n453), .Z(n451) );
  GTECH_NOR2 U451 ( .A(n331), .B(n454), .Z(n453) );
  GTECH_NOR2 U452 ( .A(n455), .B(n333), .Z(n452) );
  GTECH_NOR2 U453 ( .A(n456), .B(n457), .Z(n455) );
  GTECH_NOT U454 ( .A(n458), .Z(n457) );
  GTECH_NOR2 U455 ( .A(n459), .B(n460), .Z(n458) );
  GTECH_NOR2 U456 ( .A(n461), .B(n367), .Z(n460) );
  GTECH_NOR2 U457 ( .A(n462), .B(n369), .Z(n459) );
  GTECH_NOR2 U458 ( .A(n463), .B(n464), .Z(n462) );
  GTECH_NOT U459 ( .A(n465), .Z(n464) );
  GTECH_NOR2 U460 ( .A(n308), .B(n466), .Z(n465) );
  GTECH_NOR2 U461 ( .A(n420), .B(n454), .Z(n466) );
  GTECH_NOT U462 ( .A(n467), .Z(n463) );
  GTECH_NOR2 U463 ( .A(n468), .B(n469), .Z(n467) );
  GTECH_NOR2 U464 ( .A(locked), .B(n420), .Z(n469) );
  GTECH_NOR2 U465 ( .A(grant[1]), .B(n470), .Z(n468) );
  GTECH_NOT U466 ( .A(n471), .Z(n470) );
  GTECH_NOR2 U467 ( .A(n339), .B(n472), .Z(n456) );
  GTECH_NOT U468 ( .A(n473), .Z(n472) );
  GTECH_NOR2 U469 ( .A(n474), .B(n475), .Z(n473) );
  GTECH_NOR2 U470 ( .A(n283), .B(n338), .Z(n475) );
  GTECH_NOT U471 ( .A(n476), .Z(n283) );
  GTECH_NOR2 U472 ( .A(priority_vec_8), .B(n308), .Z(n476) );
  GTECH_NOR2 U473 ( .A(locked), .B(n477), .Z(n474) );
  GTECH_NOT U474 ( .A(n461), .Z(n477) );
  GTECH_NOR2 U475 ( .A(n471), .B(n448), .Z(n461) );
  GTECH_NOT U476 ( .A(n478), .Z(n448) );
  GTECH_NOR2 U477 ( .A(n308), .B(grant[1]), .Z(n478) );
  GTECH_NOT U478 ( .A(n479), .Z(n308) );
  GTECH_NOR2 U479 ( .A(n480), .B(n481), .Z(n471) );
  GTECH_NOR2 U480 ( .A(priority_vec_8), .B(n426), .Z(n481) );
  GTECH_NOT U481 ( .A(priority_vec_7), .Z(n426) );
  GTECH_NOR2 U482 ( .A(priority_vec_7), .B(n454), .Z(n480) );
  GTECH_NOT U483 ( .A(priority_vec_8), .Z(n454) );
  GTECH_NOT U484 ( .A(n482), .Z(n270) );
  GTECH_NOR2 U485 ( .A(n483), .B(n484), .Z(n482) );
  GTECH_NOR2 U486 ( .A(n485), .B(n333), .Z(n484) );
  GTECH_NOR2 U487 ( .A(n587), .B(n331), .Z(n483) );
  GTECH_NOT U488 ( .A(n486), .Z(n268) );
  GTECH_NOR2 U489 ( .A(n354), .B(n487), .Z(n486) );
  GTECH_NOT U490 ( .A(n488), .Z(n487) );
  GTECH_NOR2 U491 ( .A(n489), .B(n490), .Z(n488) );
  GTECH_NOR2 U492 ( .A(n331), .B(n491), .Z(n490) );
  GTECH_NOR2 U493 ( .A(n492), .B(n333), .Z(n489) );
  GTECH_NOR2 U494 ( .A(n493), .B(n494), .Z(n492) );
  GTECH_NOT U495 ( .A(n495), .Z(n494) );
  GTECH_NOR2 U496 ( .A(n496), .B(n497), .Z(n495) );
  GTECH_NOR2 U497 ( .A(n498), .B(n367), .Z(n497) );
  GTECH_NOR2 U498 ( .A(n499), .B(n369), .Z(n496) );
  GTECH_NOR2 U499 ( .A(n500), .B(n501), .Z(n499) );
  GTECH_NOT U500 ( .A(n502), .Z(n501) );
  GTECH_NOR2 U501 ( .A(n303), .B(n503), .Z(n502) );
  GTECH_NOR2 U502 ( .A(priority_vec[14]), .B(locked), .Z(n503) );
  GTECH_NOT U503 ( .A(n504), .Z(n500) );
  GTECH_NOR2 U504 ( .A(n505), .B(n506), .Z(n504) );
  GTECH_NOR2 U505 ( .A(priority_vec[14]), .B(grant[2]), .Z(n506) );
  GTECH_NOR2 U506 ( .A(n485), .B(n491), .Z(n505) );
  GTECH_NOR2 U507 ( .A(n339), .B(n507), .Z(n493) );
  GTECH_NOT U508 ( .A(n508), .Z(n507) );
  GTECH_NOR2 U509 ( .A(n509), .B(n510), .Z(n508) );
  GTECH_NOR2 U510 ( .A(n281), .B(n338), .Z(n510) );
  GTECH_NOT U511 ( .A(n511), .Z(n281) );
  GTECH_NOR2 U512 ( .A(priority_vec[14]), .B(n303), .Z(n511) );
  GTECH_NOR2 U513 ( .A(locked), .B(n512), .Z(n509) );
  GTECH_NOT U514 ( .A(n498), .Z(n512) );
  GTECH_NOR2 U515 ( .A(n491), .B(n513), .Z(n498) );
  GTECH_NOT U516 ( .A(n514), .Z(n266) );
  GTECH_NOR2 U517 ( .A(n354), .B(n515), .Z(n514) );
  GTECH_NOT U518 ( .A(n516), .Z(n515) );
  GTECH_NOR2 U519 ( .A(n517), .B(n518), .Z(n516) );
  GTECH_NOR2 U520 ( .A(n331), .B(n519), .Z(n518) );
  GTECH_NOT U521 ( .A(n520), .Z(n331) );
  GTECH_NOR2 U522 ( .A(n521), .B(n354), .Z(n520) );
  GTECH_NOR2 U523 ( .A(n522), .B(n333), .Z(n517) );
  GTECH_NOT U524 ( .A(n521), .Z(n333) );
  GTECH_NOR2 U525 ( .A(n523), .B(n354), .Z(n521) );
  GTECH_NOT U526 ( .A(enable), .Z(n523) );
  GTECH_NOR2 U527 ( .A(n524), .B(n525), .Z(n522) );
  GTECH_NOT U528 ( .A(n526), .Z(n525) );
  GTECH_NOR2 U529 ( .A(n527), .B(n528), .Z(n526) );
  GTECH_NOR2 U530 ( .A(n529), .B(n367), .Z(n528) );
  GTECH_NOT U531 ( .A(n530), .Z(n367) );
  GTECH_NOR2 U532 ( .A(n586), .B(n585), .Z(n530) );
  GTECH_NOR2 U533 ( .A(n531), .B(n369), .Z(n527) );
  GTECH_NOT U534 ( .A(n532), .Z(n369) );
  GTECH_NOR2 U535 ( .A(n585), .B(n330), .Z(n532) );
  GTECH_NOT U536 ( .A(n586), .Z(n330) );
  GTECH_NOR2 U537 ( .A(n533), .B(n534), .Z(n531) );
  GTECH_NOT U538 ( .A(n535), .Z(n534) );
  GTECH_NOR2 U539 ( .A(n303), .B(n536), .Z(n535) );
  GTECH_NOR2 U540 ( .A(n485), .B(n519), .Z(n536) );
  GTECH_NOT U541 ( .A(n537), .Z(n533) );
  GTECH_NOR2 U542 ( .A(n538), .B(n539), .Z(n537) );
  GTECH_NOR2 U543 ( .A(locked), .B(n485), .Z(n539) );
  GTECH_NOR2 U544 ( .A(grant[2]), .B(n540), .Z(n538) );
  GTECH_NOT U545 ( .A(n541), .Z(n540) );
  GTECH_NOR2 U546 ( .A(n339), .B(n542), .Z(n524) );
  GTECH_NOT U547 ( .A(n543), .Z(n542) );
  GTECH_NOR2 U548 ( .A(n544), .B(n545), .Z(n543) );
  GTECH_NOR2 U549 ( .A(n279), .B(n338), .Z(n545) );
  GTECH_NOT U550 ( .A(n546), .Z(n279) );
  GTECH_NOR2 U551 ( .A(priority_vec[15]), .B(n303), .Z(n546) );
  GTECH_NOR2 U552 ( .A(locked), .B(n547), .Z(n544) );
  GTECH_NOT U553 ( .A(n529), .Z(n547) );
  GTECH_NOR2 U554 ( .A(n541), .B(n513), .Z(n529) );
  GTECH_NOT U555 ( .A(n548), .Z(n513) );
  GTECH_NOR2 U556 ( .A(n303), .B(grant[2]), .Z(n548) );
  GTECH_NOT U557 ( .A(n549), .Z(n303) );
  GTECH_NOR2 U558 ( .A(n550), .B(n551), .Z(n541) );
  GTECH_NOR2 U559 ( .A(priority_vec[15]), .B(n491), .Z(n551) );
  GTECH_NOT U560 ( .A(priority_vec[14]), .Z(n491) );
  GTECH_NOR2 U561 ( .A(priority_vec[14]), .B(n519), .Z(n550) );
  GTECH_NOT U562 ( .A(priority_vec[15]), .Z(n519) );
  GTECH_NOT U563 ( .A(n585), .Z(n339) );
  GTECH_NOT U564 ( .A(init_n), .Z(n354) );
  GTECH_NOT U565 ( .A(parked), .Z(granted) );
  GTECH_NOR2 U566 ( .A(grant[1]), .B(grant[0]), .Z(grant_index[1]) );
  GTECH_NOR2 U567 ( .A(grant[0]), .B(n552), .Z(grant_index[0]) );
  GTECH_NOR2 U568 ( .A(grant[1]), .B(n485), .Z(n552) );
  GTECH_NOT U569 ( .A(n485), .Z(grant[2]) );
  GTECH_NOR2 U570 ( .A(n553), .B(n554), .Z(n485) );
  GTECH_NOR2 U571 ( .A(n338), .B(n587), .Z(n554) );
  GTECH_NOR2 U572 ( .A(n555), .B(n556), .Z(n553) );
  GTECH_NOT U573 ( .A(n557), .Z(n556) );
  GTECH_NOR2 U574 ( .A(current_index[0]), .B(n558), .Z(n557) );
  GTECH_NOT U575 ( .A(current_index[1]), .Z(n555) );
  GTECH_NOT U576 ( .A(n420), .Z(grant[1]) );
  GTECH_NOR2 U577 ( .A(n559), .B(n560), .Z(n420) );
  GTECH_NOR2 U578 ( .A(n338), .B(n589), .Z(n560) );
  GTECH_NOR2 U579 ( .A(n561), .B(n562), .Z(n559) );
  GTECH_NOT U580 ( .A(n563), .Z(n562) );
  GTECH_NOR2 U581 ( .A(current_index[1]), .B(n558), .Z(n563) );
  GTECH_NOT U582 ( .A(n347), .Z(n558) );
  GTECH_NOR2 U583 ( .A(parked), .B(locked), .Z(n347) );
  GTECH_NOT U584 ( .A(current_index[0]), .Z(n561) );
  GTECH_NOT U585 ( .A(n352), .Z(grant[0]) );
  GTECH_NOR2 U586 ( .A(parked), .B(n564), .Z(n352) );
  GTECH_NOT U587 ( .A(n565), .Z(n564) );
  GTECH_NOR2 U588 ( .A(n566), .B(n567), .Z(n565) );
  GTECH_NOR2 U589 ( .A(locked), .B(n568), .Z(n567) );
  GTECH_NOT U590 ( .A(n569), .Z(n568) );
  GTECH_NOR2 U591 ( .A(current_index[1]), .B(current_index[0]), .Z(n569) );
  GTECH_NOR2 U592 ( .A(n588), .B(n338), .Z(n566) );
  GTECH_NOR2 U593 ( .A(n570), .B(n571), .Z(parked) );
  GTECH_NOT U594 ( .A(n572), .Z(n571) );
  GTECH_NOR2 U595 ( .A(n479), .B(n414), .Z(n572) );
  GTECH_NOR2 U596 ( .A(mask[0]), .B(n573), .Z(n414) );
  GTECH_NOT U597 ( .A(request[0]), .Z(n573) );
  GTECH_NOR2 U598 ( .A(mask[1]), .B(n574), .Z(n479) );
  GTECH_NOT U599 ( .A(request[1]), .Z(n574) );
  GTECH_NOT U600 ( .A(n575), .Z(n570) );
  GTECH_NOR2 U601 ( .A(locked), .B(n549), .Z(n575) );
  GTECH_NOR2 U602 ( .A(mask[2]), .B(n576), .Z(n549) );
  GTECH_NOT U603 ( .A(request[2]), .Z(n576) );
  GTECH_NOT U604 ( .A(n338), .Z(locked) );
  GTECH_NOR2 U605 ( .A(n577), .B(n578), .Z(n338) );
  GTECH_NOT U606 ( .A(n579), .Z(n578) );
  GTECH_NOR2 U607 ( .A(n580), .B(n581), .Z(n579) );
  GTECH_NOR2 U608 ( .A(n588), .B(n582), .Z(n581) );
  GTECH_NOT U609 ( .A(lock[0]), .Z(n582) );
  GTECH_NOR2 U610 ( .A(n589), .B(n583), .Z(n580) );
  GTECH_NOT U611 ( .A(lock[1]), .Z(n583) );
  GTECH_NOR2 U612 ( .A(n587), .B(n584), .Z(n577) );
  GTECH_NOT U613 ( .A(lock[2]), .Z(n584) );
endmodule


module DW_ahb_gating ( wten, grant, grant_3t, parked, parked_3t, grant_2t, 
        parked_2t );
  input [2:0] grant;
  input [2:0] grant_3t;
  output [2:0] grant_2t;
  input wten, parked, parked_3t;
  output parked_2t;
  wire   parked_2t;
  assign grant_2t[2] = grant[2];
  assign grant_2t[1] = grant[1];
  assign grant_2t[0] = grant[0];
  assign parked_2t = parked;

endmodule


module DW_ahb_arb_32_32_0 ( hclk, hresetn, ahb_sc_arb, hready, hresp, hsel, 
        haddr, hburst, hsize, htrans, hwdata, hwrite, bus_hlock, bus_hbusreq, 
        bus_hsplit, hmaster_data, pause, ahb_big_endian, bus_hgrant, ahbarbint, 
        hready_resp_s0, hresp_s0, hrdata_s0, hmaster, hmastlock, wt_count_m15, 
        wt_count_m14, wt_count_m13, wt_count_m12, wt_count_m11, wt_count_m10, 
        wt_count_m9, wt_count_m8, wt_count_m7, wt_count_m6, wt_count_m5, 
        wt_count_m4, wt_count_m3, wt_count_m2, wt_count_m1, ahb_wt_mask, 
        ahb_wt_aps );
  input [1:0] hresp;
  input [31:0] haddr;
  input [2:0] hburst;
  input [2:0] hsize;
  input [1:0] htrans;
  input [31:0] hwdata;
  input [2:0] bus_hlock;
  input [2:0] bus_hbusreq;
  input [63:0] bus_hsplit;
  input [3:0] hmaster_data;
  output [2:0] bus_hgrant;
  output [1:0] hresp_s0;
  output [31:0] hrdata_s0;
  output [3:0] hmaster;
  output [31:0] wt_count_m15;
  output [31:0] wt_count_m14;
  output [31:0] wt_count_m13;
  output [31:0] wt_count_m12;
  output [31:0] wt_count_m11;
  output [31:0] wt_count_m10;
  output [31:0] wt_count_m9;
  output [31:0] wt_count_m8;
  output [31:0] wt_count_m7;
  output [31:0] wt_count_m6;
  output [31:0] wt_count_m5;
  output [31:0] wt_count_m4;
  output [31:0] wt_count_m3;
  output [31:0] wt_count_m2;
  output [31:0] wt_count_m1;
  output [2:1] ahb_wt_mask;
  input hclk, hresetn, ahb_sc_arb, hready, hsel, hwrite, pause, ahb_big_endian;
  output ahbarbint, hready_resp_s0, hmastlock, ahb_wt_aps;
  wire   clr_arbint, new_tfr, grant_changed, ltip, csilt, est, parked_2t,
         parked;
  wire   [9:0] ebtcount;
  wire   [3:0] def_mst;
  wire   [11:0] bus_priority;
  wire   [2:0] maskmaster;
  wire   [15:0] hsplit;
  wire   [2:0] mask;
  wire   [2:0] grant_2t;
  wire   [2:0] ibus_hbusreq;
  wire   [2:0] grant;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1;
  assign ahbarbint = 1'b0;
  assign ahb_wt_mask[2] = 1'b0;
  assign ahb_wt_mask[1] = 1'b0;
  assign ahb_wt_aps = 1'b0;
  assign hready_resp_s0 = 1'b1;
  assign hresp_s0[1] = 1'b0;
  assign hresp_s0[0] = 1'b0;
  assign hrdata_s0[31] = 1'b0;
  assign hrdata_s0[30] = 1'b0;
  assign hrdata_s0[29] = 1'b0;
  assign hrdata_s0[28] = 1'b0;
  assign hrdata_s0[27] = 1'b0;
  assign hrdata_s0[26] = 1'b0;
  assign hrdata_s0[25] = 1'b0;
  assign hrdata_s0[24] = 1'b0;
  assign hrdata_s0[23] = 1'b0;
  assign hrdata_s0[22] = 1'b0;
  assign hrdata_s0[21] = 1'b0;
  assign hrdata_s0[20] = 1'b0;
  assign hrdata_s0[19] = 1'b0;
  assign hrdata_s0[18] = 1'b0;
  assign hrdata_s0[17] = 1'b0;
  assign hrdata_s0[16] = 1'b0;
  assign hrdata_s0[15] = 1'b0;
  assign hrdata_s0[14] = 1'b0;
  assign hrdata_s0[13] = 1'b0;
  assign hrdata_s0[12] = 1'b0;
  assign hrdata_s0[11] = 1'b0;
  assign hrdata_s0[10] = 1'b0;
  assign hrdata_s0[9] = 1'b0;
  assign hrdata_s0[8] = 1'b0;
  assign hrdata_s0[7] = 1'b0;
  assign hrdata_s0[6] = 1'b0;
  assign hrdata_s0[5] = 1'b0;
  assign hrdata_s0[4] = 1'b0;
  assign hrdata_s0[3] = 1'b0;
  assign hrdata_s0[2] = 1'b0;
  assign hrdata_s0[1] = 1'b0;
  assign hrdata_s0[0] = 1'b0;
  assign hmaster[3] = 1'b0;
  assign hmaster[2] = 1'b0;

  DW_ahb_arbif_32_32_0 U_arbif ( .hclk(hclk), .hresetn(hresetn), .hsel(hsel), 
        .hready(hready), .hmaster({1'b0, 1'b0, hmaster[1:0]}), .set_ebt(1'b0), 
        .haddr(haddr), .htrans(htrans), .hsize(hsize), .hwdata({1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, hwdata}), .hwrite(hwrite), 
        .ahb_big_endian(ahb_big_endian), .clr_arbint(clr_arbint) );
  DW_ahb_ebt U_ebt ( .hclk(hclk), .hresetn(hresetn), .hready(hready), 
        .ebtcount({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .ebten(1'b0), .clr_arbint(clr_arbint), .new_tfr(new_tfr), .ltip(ltip), 
        .grant_changed(grant_changed) );
  DW_ahb_mask U_mask ( .hclk(hclk), .hresetn(hresetn), .hresp(hresp), 
        .bus_hsplit(bus_hsplit), .hmaster_data(hmaster_data), .maskmaster({
        1'b0, 1'b0, 1'b0}), .bus_priority({1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 
        1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1}), .ltip(ltip), .hready(hready), 
        .csilt(csilt), .est(est), .hsplit(hsplit), .mask(mask) );
  DW_ahb_gctrl U_gctrl ( .hclk(hclk), .hresetn(hresetn), .ahb_sc_arb(
        ahb_sc_arb), .hburst(hburst), .hready(hready), .hresp(hresp), .hsplit(
        hsplit), .htrans(htrans), .bus_hlock(bus_hlock), .def_mst({1'b0, 1'b0, 
        1'b0, 1'b1}), .pause(pause), .grant_2t(grant_2t), .parked_2t(parked_2t), .mask(mask), .set_ebt(1'b0), .bus_hbusreq(bus_hbusreq), .grant_changed(
        grant_changed), .ibus_hbusreq(ibus_hbusreq), .ltip(ltip), .csilt(csilt), .bus_hgrant(bus_hgrant), .hmastlock(hmastlock), .hmaster({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, hmaster[1:0]}), 
        .new_tfr(new_tfr), .est(est) );
  DW_ahb_bcm53_3_4_1_0_0_2 U_arb_2t ( .clk(hclk), .rst_n(hresetn), .init_n(
        1'b1), .enable(1'b1), .request(ibus_hbusreq), .prior({1'b1, 1'b1, 1'b0, 
        1'b1, 1'b1, 1'b1, 1'b1, 1'b0, 1'b1, 1'b1, 1'b1, 1'b1}), .lock({1'b0, 
        1'b0, 1'b0}), .mask(mask), .parked(parked), .grant(grant) );
  DW_ahb_gating U_gating ( .wten(1'b0), .grant(grant), .grant_3t({1'b0, 1'b0, 
        1'b0}), .parked(parked), .parked_3t(1'b0), .grant_2t(grant_2t), 
        .parked_2t(parked_2t) );
endmodule


module DW_ahb_dfltslv_32 ( hclk, hresetn, hready, htrans, hsel_none, 
        hready_resp_none, hresp_none, hrdata_none );
  input [1:0] htrans;
  output [1:0] hresp_none;
  output [31:0] hrdata_none;
  input hclk, hresetn, hready, hsel_none;
  output hready_resp_none;
  wire   current_state, next_state, n2, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24;
  assign hrdata_none[31] = 1'b0;
  assign hrdata_none[30] = 1'b0;
  assign hrdata_none[29] = 1'b0;
  assign hrdata_none[28] = 1'b0;
  assign hrdata_none[27] = 1'b0;
  assign hrdata_none[26] = 1'b0;
  assign hrdata_none[25] = 1'b0;
  assign hrdata_none[24] = 1'b0;
  assign hrdata_none[23] = 1'b0;
  assign hrdata_none[22] = 1'b0;
  assign hrdata_none[21] = 1'b0;
  assign hrdata_none[20] = 1'b0;
  assign hrdata_none[19] = 1'b0;
  assign hrdata_none[18] = 1'b0;
  assign hrdata_none[17] = 1'b0;
  assign hrdata_none[16] = 1'b0;
  assign hrdata_none[15] = 1'b0;
  assign hrdata_none[14] = 1'b0;
  assign hrdata_none[13] = 1'b0;
  assign hrdata_none[12] = 1'b0;
  assign hrdata_none[11] = 1'b0;
  assign hrdata_none[10] = 1'b0;
  assign hrdata_none[9] = 1'b0;
  assign hrdata_none[8] = 1'b0;
  assign hrdata_none[7] = 1'b0;
  assign hrdata_none[6] = 1'b0;
  assign hrdata_none[5] = 1'b0;
  assign hrdata_none[4] = 1'b0;
  assign hrdata_none[3] = 1'b0;
  assign hrdata_none[2] = 1'b0;
  assign hrdata_none[1] = 1'b0;
  assign hrdata_none[0] = 1'b0;
  assign hresp_none[1] = 1'b0;

  GTECH_FD2 current_state_reg ( .D(next_state), .CP(hclk), .CD(hresetn), .Q(
        current_state), .QN(n2) );
  GTECH_FD4 hready_resp_none_reg ( .D(n14), .CP(hclk), .SD(hresetn), .Q(
        hready_resp_none) );
  GTECH_FD2 hresp_none_reg_0_ ( .D(n15), .CP(hclk), .CD(hresetn), .Q(
        hresp_none[0]) );
  GTECH_NOT U16 ( .A(n16), .Z(n15) );
  GTECH_NOR2 U17 ( .A(n17), .B(n18), .Z(n16) );
  GTECH_NOT U18 ( .A(next_state), .Z(n14) );
  GTECH_NOR2 U19 ( .A(n19), .B(n18), .Z(next_state) );
  GTECH_NOT U20 ( .A(n2), .Z(n18) );
  GTECH_NOT U21 ( .A(n17), .Z(n19) );
  GTECH_NOR2 U22 ( .A(n20), .B(n21), .Z(n17) );
  GTECH_NOT U23 ( .A(n22), .Z(n21) );
  GTECH_NOR2 U24 ( .A(n23), .B(n24), .Z(n22) );
  GTECH_NOT U25 ( .A(hsel_none), .Z(n24) );
  GTECH_NOT U26 ( .A(hready), .Z(n23) );
  GTECH_NOT U27 ( .A(htrans[1]), .Z(n20) );
endmodule


module DW_ahb ( hclk, hresetn, haddr_m1, hburst_m1, hbusreq_m1, hlock_m1, 
        hprot_m1, hsize_m1, htrans_m1, hwdata_m1, hwrite_m1, hgrant_m1, 
        haddr_m2, hburst_m2, hbusreq_m2, hlock_m2, hprot_m2, hsize_m2, 
        htrans_m2, hwdata_m2, hwrite_m2, hgrant_m2, hsel_s1, hready_resp_s1, 
        hresp_s1, hrdata_s1, hsel_s2, hready_resp_s2, hresp_s2, hrdata_s2, 
        hsel_s3, hready_resp_s3, hresp_s3, hrdata_s3, hsel_s4, hready_resp_s4, 
        hresp_s4, hrdata_s4, haddr, hburst, hprot, hsize, htrans, hwdata, 
        hwrite, hready, hresp, hrdata, hmaster, hmaster_data, hmastlock );
  input [31:0] haddr_m1;
  input [2:0] hburst_m1;
  input [3:0] hprot_m1;
  input [2:0] hsize_m1;
  input [1:0] htrans_m1;
  input [31:0] hwdata_m1;
  input [31:0] haddr_m2;
  input [2:0] hburst_m2;
  input [3:0] hprot_m2;
  input [2:0] hsize_m2;
  input [1:0] htrans_m2;
  input [31:0] hwdata_m2;
  input [1:0] hresp_s1;
  input [31:0] hrdata_s1;
  input [1:0] hresp_s2;
  input [31:0] hrdata_s2;
  input [1:0] hresp_s3;
  input [31:0] hrdata_s3;
  input [1:0] hresp_s4;
  input [31:0] hrdata_s4;
  output [31:0] haddr;
  output [2:0] hburst;
  output [3:0] hprot;
  output [2:0] hsize;
  output [1:0] htrans;
  output [31:0] hwdata;
  output [1:0] hresp;
  output [31:0] hrdata;
  output [3:0] hmaster;
  output [3:0] hmaster_data;
  input hclk, hresetn, hbusreq_m1, hlock_m1, hwrite_m1, hbusreq_m2, hlock_m2,
         hwrite_m2, hready_resp_s1, hready_resp_s2, hready_resp_s3,
         hready_resp_s4;
  output hgrant_m1, hgrant_m2, hsel_s1, hsel_s2, hsel_s3, hsel_s4, hwrite,
         hready, hmastlock;
  wire   hsel_5_, hready_resp_none;
  wire   [31:0] hrdata_none;
  wire   [1:0] hresp_none;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6;
  assign hmaster[3] = 1'b0;
  assign hmaster[2] = 1'b0;
  assign hmaster_data[3] = 1'b0;
  assign hmaster_data[2] = 1'b0;

  DW_ahb_mux_32_32 U_mux ( .hclk(hclk), .hresetn(hresetn), .bus_haddr({
        haddr_m2, haddr_m1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .bus_hburst({hburst_m2, hburst_m1, 1'b0, 1'b0, 1'b0}), .hmaster({1'b0, 1'b0, 
        hmaster[1:0]}), .bus_hprot({hprot_m2, hprot_m1, 1'b0, 1'b0, 1'b1, 1'b1}), .bus_hsize({hsize_m2, hsize_m1, 1'b0, 1'b0, 1'b0}), .bus_htrans({htrans_m2, 
        htrans_m1, 1'b0, 1'b0}), .bus_hwdata({hwdata_m2, hwdata_m1, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .bus_hwrite({hwrite_m2, 
        hwrite_m1, 1'b0}), .hrdata_none({1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0}), .hready_resp_none(hready_resp_none), .hresp_none({1'b0, 
        hresp_none[0]}), .bus_hready({hready_resp_s4, hready_resp_s3, 
        hready_resp_s2, hready_resp_s1, 1'b1}), .bus_hresp({hresp_s4, hresp_s3, 
        hresp_s2, hresp_s1, 1'b0, 1'b0}), .bus_hrdata({hrdata_s4, hrdata_s3, 
        hrdata_s2, hrdata_s1, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .hsel({hsel_s4, hsel_s3, hsel_s2, hsel_s1, 1'b0}), .hmaster_data({
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, hmaster_data[1:0]}), 
        .haddr(haddr), .hburst(hburst), .hprot(hprot), .hsize(hsize), .htrans(
        htrans), .hwdata(hwdata), .hwrite(hwrite), .hrdata(hrdata), .hready(
        hready), .hresp(hresp) );
  DW_ahb_dcdr_32_00080000_00080fff_40000000_4000ffff U_dcdr ( .haddr(haddr), 
        .remap_n(1'b1), .hsel({hsel_5_, hsel_s4, hsel_s3, hsel_s2, hsel_s1, 
        SYNOPSYS_UNCONNECTED__2}) );
  DW_ahb_arb_32_32_0 U_arb ( .hclk(hclk), .hresetn(hresetn), .ahb_sc_arb(1'b0), 
        .hready(hready), .hresp(hresp), .hsel(1'b0), .haddr(haddr), .hburst(
        hburst), .hsize(hsize), .htrans(htrans), .hwdata(hwdata), .hwrite(
        hwrite), .bus_hlock({hlock_m2, hlock_m1, 1'b0}), .bus_hbusreq({
        hbusreq_m2, hbusreq_m1, 1'b0}), .bus_hsplit({1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), .hmaster_data({1'b0, 1'b0, hmaster_data[1:0]}), .pause(1'b0), 
        .ahb_big_endian(1'b1), .bus_hgrant({hgrant_m2, hgrant_m1, 
        SYNOPSYS_UNCONNECTED__3}), .hmaster({SYNOPSYS_UNCONNECTED__4, 
        SYNOPSYS_UNCONNECTED__5, hmaster[1:0]}), .hmastlock(hmastlock) );
  DW_ahb_dfltslv_32 U_dfltslv ( .hclk(hclk), .hresetn(hresetn), .hready(hready), .htrans(htrans), .hsel_none(hsel_5_), .hready_resp_none(hready_resp_none), 
        .hresp_none({SYNOPSYS_UNCONNECTED__6, hresp_none[0]}) );
endmodule

