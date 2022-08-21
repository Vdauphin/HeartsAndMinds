import gulp from 'gulp';
import fs from 'fs';
import { pack } from 'gulp-armapbo';

const getDirectories = source => fs.readdirSync(source, { withFileTypes: true }).filter(item => item.isDirectory()).map(item => item.name);

const templateDirectories = getDirectories('../templates');

gulp.task('prepare', () => {
    var stream = gulp.src('../src/**/*');

    templateDirectories.forEach(folder => stream = stream.pipe(gulp.dest(`../artifacts/${folder}/`)));

    return stream;
});

templateDirectories.map(folder => {
    gulp.task(folder, () => {
        return gulp.src(`../artifacts/${folder}/**/*`)
            .pipe(pack({
                fileName: `${folder}.pbo`,
                compress: [
                    '**/*.sqf',
                    'mission.sqm',
                    'description.ext'
                ]
            }))
            .pipe(gulp.dest('../artifacts'));
    });
});

gulp.task('default', gulp.series('prepare', ...templateDirectories));