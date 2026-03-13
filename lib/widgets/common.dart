// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import '../theme/app_theme.dart';
// import '../models/app_data.dart';

// // ─── Section Header ─────────────────────────────────────────────────────────
// class SectionHeader extends StatelessWidget {
//   final String eyebrow, title;
//   final String? subtitle;
//   final bool centered, dark;
//   const SectionHeader({super.key, required this.eyebrow, required this.title, this.subtitle,
//       this.centered = true, this.dark = false});

//   @override
//   Widget build(BuildContext context) {
//     final align = centered ? CrossAxisAlignment.center : CrossAxisAlignment.start;
//     final ta = centered ? TextAlign.center : TextAlign.start;
//     return Column(crossAxisAlignment: align, children: [
//       // Station F-style eyebrow: all-caps small label
//       Text(eyebrow.toUpperCase(),
//         style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.6,
//             color: dark ? AppTheme.green : AppTheme.green)),
//       const SizedBox(height: 12),
//       // DM Serif Display — editorial feel
//       Text(title, textAlign: ta,
//         style: GoogleFonts.dmSerifDisplay(
//           fontSize: 38, color: dark ? AppTheme.darkTextHi : AppTheme.ink, height: 1.12,
//         )),
//       if (subtitle != null) ...[
//         const SizedBox(height: 14),
//         ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 580),
//           child: Text(subtitle!, textAlign: ta,
//             style: GoogleFonts.dmSans(fontSize: 16, color: dark ? AppTheme.darkTextLo : AppTheme.inkMid, height: 1.68)),
//         ),
//       ],
//     ]);
//   }
// }

// // ─── Primary Button ─────────────────────────────────────────────────────────
// class PrimaryButton extends StatefulWidget {
//   final String text;
//   final VoidCallback? onPressed;
//   final bool isOutlined, dark;
//   final IconData? icon;
//   const PrimaryButton({super.key, required this.text, this.onPressed, this.isOutlined = false,
//       this.icon, this.dark = false});
//   @override State<PrimaryButton> createState() => _PBState();
// }
// class _PBState extends State<PrimaryButton> {
//   bool _h = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _h = true),
//       onExit:  (_) => setState(() => _h = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 170),
//         decoration: widget.isOutlined
//             ? BoxDecoration(
//                 borderRadius: BorderRadius.circular(7),
//                 border: Border.all(color: widget.dark ? Colors.white.withOpacity(0.25) : AppTheme.stroke),
//                 color: _h ? AppTheme.paperStripe : Colors.transparent,
//               )
//             : BoxDecoration(
//                 color: _h ? AppTheme.greenDark : AppTheme.green,
//                 borderRadius: BorderRadius.circular(7),
//                 boxShadow: _h ? [BoxShadow(color: AppTheme.green.withOpacity(0.3), blurRadius: 16, offset: const Offset(0,5))] : [],
//               ),
//         child: TextButton(
//           onPressed: widget.onPressed ?? () {},
//           style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
//           ),
//           child: Row(mainAxisSize: MainAxisSize.min, children: [
//             Text(widget.text, style: GoogleFonts.dmSans(
//               fontSize: 14, fontWeight: FontWeight.w600,
//               color: widget.isOutlined ? (widget.dark ? Colors.white : AppTheme.ink) : Colors.white,
//             )),
//             if (widget.icon != null) ...[
//               const SizedBox(width: 7),
//               Icon(widget.icon, size: 15, color: widget.isOutlined ? (widget.dark ? Colors.white : AppTheme.ink) : Colors.white),
//             ],
//           ]),
//         ),
//       ),
//     );
//   }
// }

// // ─── Service Card ────────────────────────────────────────────────────────────
// class ServiceCard extends StatefulWidget {
//   final Service service;
//   final bool dark;
//   const ServiceCard({super.key, required this.service, this.dark = false});
//   @override State<ServiceCard> createState() => _SCState();
// }
// class _SCState extends State<ServiceCard> {
//   bool _h = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _h = true),
//       onExit:  (_) => setState(() => _h = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 220),
//         padding: const EdgeInsets.all(26),
//         decoration: BoxDecoration(
//           color: widget.dark ? AppTheme.darkSurface : AppTheme.paper,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(
//             color: _h ? AppTheme.green.withOpacity(0.45) : (widget.dark ? AppTheme.darkStroke : AppTheme.stroke),
//             width: _h ? 1.5 : 1,
//           ),
//           boxShadow: _h
//               ? [BoxShadow(color: AppTheme.green.withOpacity(0.1), blurRadius: 24, offset: const Offset(0, 6))]
//               : [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 2))],
//         ),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             Container(
//               width: 48, height: 48,
//               decoration: BoxDecoration(color: AppTheme.greenLight, borderRadius: BorderRadius.circular(12)),
//               child: Icon(widget.service.icon, size: 22, color: AppTheme.green),
//             ),
//             Container(
//               padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
//               decoration: BoxDecoration(color: AppTheme.blueLight, borderRadius: BorderRadius.circular(4)),
//               child: Text(widget.service.tag, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w600, color: AppTheme.blue)),
//             ),
//           ]),
//           const SizedBox(height: 18),
//           Text(widget.service.title, style: GoogleFonts.dmSans(
//             fontSize: 17, fontWeight: FontWeight.w700,
//             color: widget.dark ? AppTheme.darkTextHi : AppTheme.ink, height: 1.3,
//           )),
//           const SizedBox(height: 8),
//           Text(widget.service.description, style: GoogleFonts.dmSans(
//             fontSize: 13, color: widget.dark ? AppTheme.darkTextLo : AppTheme.inkMid, height: 1.6,
//           ), maxLines: 3, overflow: TextOverflow.ellipsis),
//           const SizedBox(height: 16),
//           ...widget.service.features.take(3).map((f) => Padding(
//             padding: const EdgeInsets.only(bottom: 7),
//             child: Row(children: [
//               Container(width: 15, height: 15, decoration: BoxDecoration(color: AppTheme.greenLight, shape: BoxShape.circle),
//                 child: const Icon(Icons.check, size: 9, color: AppTheme.green)),
//               const SizedBox(width: 7),
//               Expanded(child: Text(f, style: GoogleFonts.dmSans(fontSize: 12,
//                 color: widget.dark ? AppTheme.darkTextLo : AppTheme.inkMid))),
//             ]),
//           )),
//           const SizedBox(height: 14),
//           Row(children: [
//             Text('Learn more', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.green)),
//             const SizedBox(width: 3),
//             AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               transform: Matrix4.translationValues(_h ? 4 : 0, 0, 0),
//               child: const Icon(Icons.arrow_forward_rounded, size: 13, color: AppTheme.green),
//             ),
//           ]),
//         ]),
//       ),
//     );
//   }
// }

// // ─── Project Card ─────────────────────────────────────────────────────────────
// class ProjectCard extends StatefulWidget {
//   final Project project;
//   const ProjectCard({super.key, required this.project});
//   @override State<ProjectCard> createState() => _PCState();
// }
// class _PCState extends State<ProjectCard> {
//   bool _h = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _h = true),
//       onExit:  (_) => setState(() => _h = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(_h ? 0.14 : 0.06),
//               blurRadius: _h ? 28 : 10, offset: Offset(0, _h ? 10 : 3))],
//         ),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: Stack(children: [
//             SizedBox(height: 280, width: double.infinity,
//               child: Image.network(widget.project.imageUrl, fit: BoxFit.cover,
//                 errorBuilder: (_, __, ___) => Container(
//                   color: AppTheme.paperStripe,
//                   child: const Icon(Icons.image_outlined, size: 40, color: AppTheme.inkFaint)))),
//             Positioned.fill(child: AnimatedContainer(
//               duration: const Duration(milliseconds: 300),
//               decoration: BoxDecoration(gradient: LinearGradient(
//                 colors: [Colors.transparent, Colors.black.withOpacity(_h ? 0.88 : 0.72)],
//                 begin: Alignment.topCenter, end: Alignment.bottomCenter,
//               )),
//             )),
//             Positioned(top: 14, left: 14, child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//               decoration: BoxDecoration(color: AppTheme.green, borderRadius: BorderRadius.circular(5)),
//               child: Text(widget.project.category, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: Colors.white)),
//             )),
//             Positioned(bottom: 0, left: 0, right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(18),
//                 child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                   Text(widget.project.client, style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.green, fontWeight: FontWeight.w600)),
//                   const SizedBox(height: 3),
//                   Text(widget.project.title, style: GoogleFonts.dmSerifDisplay(fontSize: 18, color: Colors.white)),
//                   const SizedBox(height: 7),
//                   Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//                     decoration: BoxDecoration(color: Colors.white.withOpacity(0.12),
//                         borderRadius: BorderRadius.circular(5), border: Border.all(color: Colors.white.withOpacity(0.2))),
//                     child: Text('🏆  ${widget.project.result}',
//                         style: GoogleFonts.dmSans(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white)),
//                   ),
//                 ]),
//               )),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// // ─── Testimonial Card ─────────────────────────────────────────────────────────
// class TestimonialCard extends StatelessWidget {
//   final Testimonial testimonial;
//   final bool dark;
//   const TestimonialCard({super.key, required this.testimonial, this.dark = false});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(26),
//       decoration: BoxDecoration(
//         color: dark ? AppTheme.darkSurface : AppTheme.paper,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: dark ? AppTheme.darkStroke : AppTheme.stroke),
//         boxShadow: dark ? [] : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 12, offset: const Offset(0,3))],
//       ),
//       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//         Row(children: List.generate(5, (_) => const Icon(Icons.star_rounded, size: 14, color: AppTheme.gold))),
//         const SizedBox(height: 14),
//         Text('"${testimonial.content}"', style: GoogleFonts.dmSans(
//           fontSize: 14, color: dark ? AppTheme.darkTextLo : AppTheme.inkMid, height: 1.7, fontStyle: FontStyle.italic)),
//         const SizedBox(height: 20),
//         Row(children: [
//           CircleAvatar(radius: 20, backgroundImage: NetworkImage(testimonial.imageUrl), backgroundColor: AppTheme.paperStripe),
//           const SizedBox(width: 10),
//           Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Text(testimonial.name, style: GoogleFonts.dmSans(fontSize: 13, fontWeight: FontWeight.w700,
//                 color: dark ? AppTheme.darkTextHi : AppTheme.ink)),
//             Text('${testimonial.role}, ${testimonial.company}',
//                 style: GoogleFonts.dmSans(fontSize: 11, color: dark ? AppTheme.darkTextLo : AppTheme.inkLight)),
//           ]),
//         ]),
//       ]),
//     );
//   }
// }

// // ─── FAQ Tile ─────────────────────────────────────────────────────────────────
// class FaqTile extends StatefulWidget {
//   final FaqItem item;
//   final bool dark;
//   const FaqTile({super.key, required this.item, this.dark = false});
//   @override State<FaqTile> createState() => _FaqState();
// }
// class _FaqState extends State<FaqTile> {
//   bool _open = false;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 8),
//       decoration: BoxDecoration(
//         color: widget.dark ? AppTheme.darkSurface : AppTheme.paper,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(
//           color: _open ? AppTheme.green.withOpacity(0.5) : (widget.dark ? AppTheme.darkStroke : AppTheme.stroke),
//           width: _open ? 1.5 : 1,
//         ),
//         boxShadow: _open ? [BoxShadow(color: AppTheme.green.withOpacity(0.07), blurRadius: 12, offset: const Offset(0,3))] : [],
//       ),
//       clipBehavior: Clip.antiAlias,
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           onTap: () => setState(() => _open = !_open),
//           splashColor: AppTheme.green.withOpacity(0.05),
//           highlightColor: AppTheme.green.withOpacity(0.03),
//           child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//             Padding(
//               padding: const EdgeInsets.all(18),
//               child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
//                 Expanded(child: Text(widget.item.question, style: GoogleFonts.dmSans(
//                   fontSize: 15, fontWeight: FontWeight.w600,
//                   color: widget.dark ? AppTheme.darkTextHi : AppTheme.ink, height: 1.3))),
//                 const SizedBox(width: 14),
//                 AnimatedContainer(
//                   duration: const Duration(milliseconds: 220),
//                   width: 28, height: 28,
//                   decoration: BoxDecoration(
//                     color: _open ? AppTheme.green : AppTheme.greenLight,
//                     borderRadius: BorderRadius.circular(7),
//                   ),
//                   child: AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 200),
//                     transitionBuilder: (c, a) => ScaleTransition(scale: a, child: c),
//                     child: Icon(
//                       _open ? Icons.remove_rounded : Icons.add_rounded,
//                       key: ValueKey(_open), size: 15,
//                       color: _open ? Colors.white : AppTheme.green,
//                     ),
//                   ),
//                 ),
//               ]),
//             ),
//             AnimatedSize(
//               duration: const Duration(milliseconds: 280),
//               curve: Curves.easeInOutCubic,
//               child: _open
//                   ? Padding(
//                       padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
//                       child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//                         Divider(color: widget.dark ? AppTheme.darkStroke : AppTheme.stroke, height: 1),
//                         const SizedBox(height: 14),
//                         Text(widget.item.answer, style: GoogleFonts.dmSans(
//                           fontSize: 14, color: widget.dark ? AppTheme.darkTextLo : AppTheme.inkMid, height: 1.7)),
//                       ]),
//                     )
//                   : const SizedBox.shrink(),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }

// // ─── Team Card ────────────────────────────────────────────────────────────────
// class TeamCard extends StatefulWidget {
//   final TeamMember member;
//   const TeamCard({super.key, required this.member});
//   @override State<TeamCard> createState() => _TCState();
// }
// class _TCState extends State<TeamCard> {
//   bool _h = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _h = true),
//       onExit:  (_) => setState(() => _h = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: AppTheme.paper,
//           borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: _h ? AppTheme.green.withOpacity(0.4) : AppTheme.stroke),
//           boxShadow: _h
//               ? [BoxShadow(color: AppTheme.green.withOpacity(0.12), blurRadius: 20, offset: const Offset(0,6))]
//               : [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0,2))],
//         ),
//         child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: AspectRatio(
//               aspectRatio: 1.1,
//               child: Stack(fit: StackFit.expand, children: [
//                 Image.network(member.imageUrl, fit: BoxFit.cover,
//                   loadingBuilder: (_, child, prog) => prog == null ? child
//                       : Container(color: AppTheme.paperStripe, child: const Center(child: CircularProgressIndicator(strokeWidth: 2, color: AppTheme.green))),
//                   errorBuilder: (_, __, ___) => Container(color: AppTheme.paperStripe,
//                     child: const Icon(Icons.person_rounded, size: 56, color: AppTheme.inkFaint))),
//                 const DecoratedBox(decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     colors: [Colors.transparent, Color(0xCC0C120E)],
//                     begin: Alignment.topCenter, end: Alignment.bottomCenter, stops: [0.5, 1.0],
//                   ),
//                 )),
//               ]),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Text(member.name, style: GoogleFonts.dmSerifDisplay(fontSize: 17, color: AppTheme.ink)),
//               const SizedBox(height: 3),
//               Text(member.role, style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w500, color: AppTheme.green)),
//               const SizedBox(height: 9),
//               Text(member.bio, style: GoogleFonts.dmSans(fontSize: 12, color: AppTheme.inkMid, height: 1.55)),
//               const SizedBox(height: 14),
//               Wrap(spacing: 7, runSpacing: 7, children: const [
//                 _SocialChip(icon: Icons.link_rounded,        label: 'LinkedIn'),
//                 _SocialChip(icon: Icons.camera_alt_outlined, label: 'Instagram'),
//               ]),
//             ]),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class _SocialChip extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   const _SocialChip({required this.icon, required this.label});
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
//       decoration: BoxDecoration(
//         color: AppTheme.paperStripe, borderRadius: BorderRadius.circular(5),
//         border: Border.all(color: AppTheme.stroke),
//       ),
//       child: Row(mainAxisSize: MainAxisSize.min, children: [
//         Icon(icon, size: 11, color: AppTheme.inkLight),
//         const SizedBox(width: 4),
//         Text(label, style: GoogleFonts.dmSans(fontSize: 10, color: AppTheme.inkLight)),
//       ]),
//     );
//   }
// }

// // ─── Blog Card ────────────────────────────────────────────────────────────────
// class BlogCard extends StatefulWidget {
//   final BlogPost post;
//   const BlogCard({super.key, required this.post});
//   @override State<BlogCard> createState() => _BCState();
// }
// class _BCState extends State<BlogCard> {
//   bool _h = false;
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       cursor: SystemMouseCursors.click,
//       onEnter: (_) => setState(() => _h = true),
//       onExit:  (_) => setState(() => _h = false),
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 200),
//         decoration: BoxDecoration(
//           color: AppTheme.paper, borderRadius: BorderRadius.circular(12),
//           border: Border.all(color: _h ? AppTheme.green.withOpacity(0.3) : AppTheme.stroke),
//           boxShadow: [BoxShadow(color: Colors.black.withOpacity(_h ? 0.09 : 0.03),
//               blurRadius: _h ? 20 : 6, offset: Offset(0, _h ? 6 : 1))],
//         ),
//         child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//           ClipRRect(
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
//             child: Image.network(post.imageUrl, height: 170, width: double.infinity, fit: BoxFit.cover,
//               errorBuilder: (_, __, ___) => Container(height: 170, color: AppTheme.paperStripe)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(18),
//             child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
//               Row(children: [
//                 Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
//                   decoration: BoxDecoration(color: AppTheme.greenLight, borderRadius: BorderRadius.circular(4)),
//                   child: Text(post.category, style: GoogleFonts.dmSans(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.greenDark)),
//                 ),
//                 const Spacer(),
//                 Text('${post.readMin} min read', style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.inkFaint)),
//               ]),
//               const SizedBox(height: 11),
//               Text(post.title, style: GoogleFonts.dmSerifDisplay(fontSize: 16, color: AppTheme.ink, height: 1.35),
//                 maxLines: 2, overflow: TextOverflow.ellipsis),
//               const SizedBox(height: 7),
//               Text(post.excerpt, style: GoogleFonts.dmSans(fontSize: 13, color: AppTheme.inkMid, height: 1.5),
//                 maxLines: 2, overflow: TextOverflow.ellipsis),
//               const SizedBox(height: 14),
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                 Text(post.date, style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.inkFaint)),
//                 Row(children: [
//                   Text('Read', style: GoogleFonts.dmSans(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.green)),
//                   const SizedBox(width: 3),
//                   const Icon(Icons.arrow_forward_rounded, size: 12, color: AppTheme.green),
//                 ]),
//               ]),
//             ]),
//           ),
//         ]),
//       ),
//     );
//   }
// }